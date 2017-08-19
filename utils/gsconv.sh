#!/bin/sh

set -e
set -x
set -u

gs_batch() {
    gs -dBATCH -dNOPAUSE "$@"
}

parse_cmyk() {
    local c=$1 ; shift
    local m=$1 ; shift
    local y=$1 ; shift
    local k=$1 ; shift

    echo 'local c_i='${c%.*}
    echo 'local m_i='${m%.*}
    echo 'local y_i='${y%.*}
    echo 'local k_i='${k%.*}

    echo 'local c_f='${c#*.}
    echo 'local m_f='${m#*.}
    echo 'local y_f='${y#*.}
    echo 'local k_f='${k#*.}
}

colorconv() {
    local pdf=$1 ; shift

    local tmpdir="/tmp/gs"

    local reprint_tgt="${pdf%.pdf}.gs.pdf"
    local color_tgt="${pdf%.pdf}.gs-color.pdf"
    local gray_tgt="${pdf%.pdf}.gs-gray.pdf"
    mkdir "$tmpdir"
    local ps_template="$tmpdir/pdf-%04d.ps"
    local ps_file="$tmpdir/pdf.ps"
    gs_batch -o"$ps_file" -dPDFSETTINGS=/printer -sDEVICE=ps2write "$pdf"
    gs_batch -o"$ps_template" -dPDFSETTINGS=/printer -sDEVICE=ps2write \
        "$ps_file"
    gs_batch -o"$reprint_tgt" -dPDFSETTINGS=/printer -sDEVICE=pdfwrite \
        "$ps_file"
    local line
    rm -f "$tmpdir/gray.lst"
    rm -f "$tmpdir/color.lst"
    gs_batch -o- -sDEVICE=inkcov "$reprint_tgt" \
        | sed '/^Page \d\{1,\}$/!N;s/\n/|/' \
        | while read line ; do
            echo "$line" >> "$tmpdir/lines.txt"
            if test "${line%CMYK OK}" = "${line}" ; then
                continue
            fi
            line="${line#Page }"
            line="${line%CMYK OK}"
            local linenr="${line%\|*}"
            local cmyk="${line#*|}"
            eval "$(parse_cmyk $cmyk)"
            if test "$c_i" -eq 0 && test "$c_f" -eq 0 \
                && test "$m_i" -eq 0 && test "$m_f" -eq 0 \
                && test "$y_i" -eq 0 && test "$y_f" -eq 0 ; then
                printf " $ps_template" "$linenr" >> "$tmpdir/gray.lst"
            else
                printf " $ps_template" "$linenr" >> "$tmpdir/color.lst"
            fi
        done
    if test -e "$tmpdir/gray.lst" ; then
        gs_batch -o"$gray_tgt" -sDEVICE=pdfwrite $(cat "$tmpdir/gray.lst")
    fi
    if test -e "$tmpdir/color.lst" ; then
        gs_batch -o"$color_tgt" -sDEVICE=pdfwrite $(cat "$tmpdir/color.lst")
    fi
    rm -r "$tmpdir"
}

colorconv "$@"
