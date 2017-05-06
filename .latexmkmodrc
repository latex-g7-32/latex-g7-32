use File::Path qw(make_path);
use File::Which;
use File::Copy;

$ENV{TEXINPUTS} = $ENV{BIBINPUTS} = "../tex$Config{path_sep}";

$MSWin_back_slash = 0;
$cleanup_includes_cusdep_generated = 1;
$bibtex_use = 2;
$pdf_mode = 1;
$recorder = 1;

$graphics_dir = "../graphics";
$inc_dir = "inc";
$src_dir = "src";
$error_basename = "$inc_dir/error";

sub custom_transform_cus_dep {
    my ($name, $all) = @_;
    if ($all){
        if ($name =~ /^$inc_dir\/$src_dir/) {
            $name =~ s!^$inc_dir(?=/)!..!;
        } else {
            $name = '';
        }
    } else {
        $name =~ s!^$inc_dir(?=/)!$graphics_dir!;
    }
    return $name;
}

sub make_dir_for_file {
    my $path = (fileparse($_[0]))[1];
    make_path($path);
}

my %exists_prog;
foreach $prog ('inkscape', 'dot', 'dia', 'pygmentize'){
    $exists_prog{$prog} = !!which($prog);
}

$pdflatex = "xelatex -interaction=nonstopmode -shell-escape %O "
    .(($exists_prog{pygmentize})?"%S":"\"\\def\\NoMinted{}\\input{%S}\"");

if ($exists_prog{dot}){
    add_cus_dep('dot', 'pdf', 0, 'dot2pdf');
} else {
    add_cus_dep('dot', 'pdf', 0, 'error_pdf');
}

if ($exists_prog{inkscape}){
    add_cus_dep('svg', 'pdf', 0, 'svg2pdf');
} else {
    add_cus_dep('svg', 'pdf', 0, 'error_pdf');
}

if ($exists_prog{dia} && $exists_prog{inkscape}){
    add_cus_dep('dia', 'pdf', 0, 'dia2pdf');
} else {
    add_cus_dep('dia', 'pdf', 0, 'error_pdf');
}

add_cus_dep( 'nlo', 'nls', 0, 'nlo2nls' );

sub nlo2nls {
    system("makeindex -s nomencl.ist -o \"$cusdep_dest\" \"$cusdep_source\"" );
}

#for source files
sub all_cus_dep {
    make_dir_for_file($cusdep_dest);
    copy($cusdep_source, $cusdep_dest);
    return 0;
}

sub add_tmp {
    my ($name, $num) = @_;
    my ($base_name, $path, $ext)=fileparse($name, qr/\.[^.]*/);
    if ($#_ == 2){
        $ext = $_[2];
    } else {
        $ext =~ s/^\.*//g;
    }
    return "$path$base_name-tmp$num.$ext";
}

set_cus_dep_transform('custom_transform_cus_dep');
add_cus_dep('all_cus_dep');

sub error_pdf {
    if (!-f "$error_basename.pdf"){
        make_dir_for_file("$error_basename.pdf");
        open(my $fh, '>', "$error_basename.tex") or die("Can't open file $error_basename.tex");
        print $fh '\\documentclass{standalone}\\begin{document}No image\\end{document}';
        close $fh;
        system("xelatex -jobname $error_basename $error_basename.tex");
    }
    make_dir_for_file("$_[0].pdf");
    copy("$error_basename.pdf", "$_[0].pdf");
    return 0;
}

$inkscape_cmd = "inkscape -A \"%s\" \"%s\"";
$dot_cmd = "dot -o\"%s\" -Tpdf \"%s\"";
$dia_cmd = "dia -e \"%s\" -t svg \"%s\"";
$crop_cmd = "perl ../utils/pdfcrop \"%s\" \"%s\"";

sub exec_cmd {
    if ($_[0]){
        print "Executing $_[0]\n";
        system($_[0]);
    }
}

sub dot2pdf {
    make_dir_for_file($cusdep_dest);
    foreach my $cmd (
        sprintf($dot_cmd, add_tmp($cusdep_dest, 1), $cusdep_source),
        sprintf($crop_cmd, add_tmp($cusdep_dest, 1), $cusdep_dest) 
    )
    {
        exec_cmd($cmd);
    }
    unlink(add_tmp($cusdep_dest, 1));
    return 0;
}

sub svg2pdf {
    make_dir_for_file($cusdep_dest);
    foreach my $cmd (
        sprintf($inkscape_cmd, add_tmp($cusdep_dest, 1), $cusdep_source),
        sprintf($crop_cmd, add_tmp($cusdep_dest, 1), $cusdep_dest)
    ) {
        exec_cmd($cmd);
    }
    unlink(add_tmp($cusdep_dest, 1));
    return 0;
}

sub dia2pdf {
    make_dir_for_file($cusdep_dest);
    foreach my $cmd (
        sprintf($dia_cmd, add_tmp($cusdep_dest, 1, 'svg'), $cusdep_source),
        sprintf($inkscape_cmd,  add_tmp($cusdep_dest, 2),  add_tmp($cusdep_dest, 1, 'svg')),
        sprintf($crop_cmd,  add_tmp($cusdep_dest, 2), $cusdep_dest)
    ) {
        exec_cmd($cmd);
    }
    unlink(add_tmp($cusdep_dest, 1, 'svg'));
    unlink(add_tmp($cusdep_dest, 2));
    return 0;
}
