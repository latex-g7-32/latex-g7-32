#!/usr/bin/env python3
"""Installer for g7-32 LaTeX style

Usage:
    install.py ([move] | copy | symlink) ([--keep-existing] | --overwrite-existing) ([--update-packages] | --no-update-packages)
    install.py --help
    install.py --version

Options:
    -k --keep-existing       Keep existing files
    -o --overwrite-existing  Overwrite existing files
    -u --update-packages     Update packages
    -n --update-packages     Don't update packages
    -h --help                Show this screen
    --version                Show version
"""
__version__ = '1.0.0'

import os
import sys
from os import symlink, remove
from pathlib import Path
from shutil import copyfile as copy, move
from docopt import docopt
from subprocess import call
import logging
logging.basicConfig(level=logging.DEBUG)

if __name__ == '__main__':
    args = docopt(__doc__, version=__version__)
    current_dir = Path(sys.argv[0]).parent.absolute()
    src_tex = Path(current_dir/"../tex")
    src_lyx = Path(current_dir/"../lyx")
    texmf = Path(os.environ.get('TEXMFHOME', os.path.expanduser("~/texmf")))
    tex = texmf/"tex"
    inc = tex/"inc"
    g2_105 = tex/"latex/G2-105"
    g7_32 = tex/"latex/G7-32"
    base = tex/"latex/base"
    bibtex = texmf/"bibtex/bst/gost780u"
    lyx = Path(os.path.expanduser("~/.lyx/layouts"))
    destinations = [texmf, tex, g2_105, g7_32, base, bibtex, lyx];
    logging.debug("destinations: {}".format(destinations))
    for x in destinations:
        try:
            x.mkdir(parents=True)
        except FileExistsError:
            pass
    move_function = lambda src, dst: move(str(src), str(dst))
    if args['copy']:
        move_function = lambda src, dst: copy(str(src), str(dst))
    elif args['symlink']:
        move_function = lambda src, dst: symlink(str(src), str(dst/src.name))
    destination_source = {
        inc: src_tex.glob("*.inc.tex"),
        g2_105: [src_tex/"G2-105.sty"],
        g7_32: [src_tex/"G7-32.sty", src_tex/"cyrtimespatched.sty", src_tex/"GostBase.clo"],
        base: [src_tex/"G7-32.cls"],
        bibtex: [src_tex/"gost780u.bst"],
        lyx: src_lyx.glob("layouts/*"),
    }
    logging.debug("dict {}".format(destination_source))
    for destination, source in destination_source.items():
        logging.debug("copying to {}".format(destination))
        for f in source:
            if args['--overwrite-existing']:
                try:
                    logging.debug("trying to remove {}".format(destination/f.name))
                    remove(str(destination/f.name))
                except FileNotFoundError:
                    pass
            move_function(f.absolute(), destination.absolute())
    if args['--update-packages']:
        try:
            call("texhash", shell=True)
        except:
            pass