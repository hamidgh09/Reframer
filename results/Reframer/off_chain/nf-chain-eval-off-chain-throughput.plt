#!/usr/bin/gnuplot
load "../../common.plot"

font_type = "Helvetica,28"
font_type_bold = "Helvetica-Bold,28"

set terminal pdf dl 1.5 enhanced dashed size 10.0, 5.5 font font_type
set output "nf-chain-eval-off-chain-throughput-multicore.pdf"

set style fill solid 2 border lt -1
set datafile separator " "
set style data errorbars

### Variables
points_lw = 3
points_size = 2.0

x_start = 3
x_offset = 1.5
windows = 30
min_y = 0
max_y = 70
y_scale = 1

### Input files
input_file_nf_chain_tput_baseline = "data/BaselineTHROUGHPUT.csv"
input_file_nf_chain_tput_reframer_16us = "data/Reframer-16THROUGHPUT.csv"
input_file_nf_chain_tput_reframer_64us = "data/Reframer-64THROUGHPUT.csv"
input_file_nf_chain_tput_reframer_128us = "data/Reframer-128THROUGHPUT.csv"

### Border
set border 1+2+4+8 lw 2

### Margins
bm = 0.137
tm = 0.984
lm = 0.09
rm = 0.995

x1 = x_start
x2 = windows + x_offset
y1 = min_y
y2 = max_y

set bmargin at screen bm
set tmargin at screen tm
set lmargin at screen lm
set rmargin at screen rm

### X-axis
set xlabel "Number of parallel trace segments"
set xlabel font font_type_bold
set xlabel offset 0,0.2
set xrange [x1:x2]
set xtics border in scale 1,0.5 norotate autojustify mirror
set xtics 2

### Y-axis
set ylabel "{/Helvetica:Bold Throughput (Gbps)}"
set ylabel offset 0.2,-0.5
set ytics border in scale 1,0.5 norotate nomirror
set ytics mirror 4
# set format y "%.1f"
set yrange [y1:y2]

### Grid
unset grid
set grid xtics lw 3.0 lt 0
set grid ytics lw 3.0 lt 0

### Legend
set key opaque bottom Right title
set key box linestyle 1 lt rgb(black)
set key font font_type
set key vertical maxrows 4
set key width -3.7
set key height 0.5
set key samplen 3.0
set key at 17.1, 52.3

### Linestyles
set style line 1 pointtype 4 pointsize points_size linewidth points_lw lt rgb(black)
set style line 2 pointtype 3 pointsize points_size linewidth points_lw lt rgb(darkred)
set style line 3 pointtype 6 pointsize points_size linewidth points_lw lt rgb(darkgreen)
set style line 4 pointtype 8 pointsize points_size linewidth points_lw lt rgb(darkyellow)

### Arrows and label to highlight the improvement
set arrow heads back filled from 30.5,32.34 to 30.5,59.6 ls 1 linewidth 3
set label '+84%' at 28.5,42 textcolor ls 1

plot \
	input_file_nf_chain_tput_baseline       using ($1):($4):($3):($5) with errorbars ls 1 title "Baseline",\
	input_file_nf_chain_tput_reframer_16us  using ($1):($4):($3):($5) with errorbars ls 3 title "With Reframer (T_{buff}=  16 μs)",\
	input_file_nf_chain_tput_reframer_64us  using ($1):($4):($3):($5) with errorbars ls 2 title "With Reframer (T_{buff}=  64 μs)",\
	input_file_nf_chain_tput_reframer_128us using ($1):($4):($3):($5) with errorbars ls 4 title "With Reframer (T_{buff}=128 μs)",\
