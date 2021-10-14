#!/usr/bin/gnuplot
load "../../common.plot"

font_type = "Helvetica,28"
font_type_bold = "Helvetica-Bold,28"

set terminal pdf dl 1.5 enhanced dashed size 10.0, 5.5 font font_type
set output "sensitive-flows-latency-multicore.pdf"

set style fill solid 2 border lt -1
set datafile separator " "
set style data errorbars

### Variables
points_lw = 3
points_size = 2.0

x_start = 2
x_offset = 0
windows = 33.5
min_y = 0
max_y = 740
y_scale = 1

### Input files
input_file_nf_chain_latency_baseline = "data/Baseline/BaselineLATENCY.csv"
input_file_nf_chain_latency_reframer_mice = "data/Small/LATENCY.csv"
input_file_nf_chain_latency_reframer_elep = "data/Large/LATENCY.csv"

### Border
set border 1+2+4+8 lw 2

### Margins
bm = 0.137
tm = 0.994
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
set ylabel "{/Helvetica:Bold Latency (μs)}"
set ylabel offset 1.2,-0.5
set ytics border in scale 1,0.5 norotate nomirror
set ytics mirror 50
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
set key width -7.5
set key height 0.5
set key samplen 3.0
set key at 23.3, 582

### Linestyles
set style line 1 pointtype 4  pointsize points_size linewidth points_lw lt rgb(black)
set style line 2 pointtype 3  pointsize points_size linewidth points_lw lt rgb(darkred)
set style line 3 pointtype 10 pointsize points_size linewidth points_lw lt rgb(darkpurple)
set style line 4 pointtype 8  pointsize points_size linewidth points_lw lt rgb(darkyellow)

### Arrows and label to highlight the improvement
set arrow heads back filled from 29.6,458.9 to 29.6,598.5 ls 3 linewidth 3
set label '-23%' at 27.2,520 textcolor ls 3

set arrow heads back filled from 30.4,419.4 to 30.4,598.5 ls 2 linewidth 3
set label '-30%' at 30.7,520 textcolor ls 2

plot \
	input_file_nf_chain_latency_baseline      using ($1):($4):($3):($5) with errorbars ls 1 title "Baseline",\
	input_file_nf_chain_latency_reframer_mice using ($1):($4):($3):($5) with errorbars ls 2 title "With Reframer (service mode) - Small flows",\
	input_file_nf_chain_latency_reframer_elep using ($1):($4):($3):($5) with errorbars ls 3 title "  With Reframer (bypass mode) - Large flows"
