#!/usr/bin/gnuplot
load "../../common.plot"

font_type = "Helvetica,28"
font_type_bold = "Helvetica-Bold,28"

set terminal pdf dl 1.5 enhanced dashed size 10.0, 5.5 font font_type
set output "nf-chain-eval-in-chain-lat999-multi-core.pdf"

set style fill solid 2 border lt -1
set datafile separator " "
set style data errorbars

### Variables
points_lw = 3
points_size = 2.0

x_start = 0
x_offset = 8
max_buf_time = 256
min_y_bot = 0
max_y_bot = 10
min_y_top = 900
max_y_top = 1750

### Input files
input_file_nf_chain_latency_baseline = "latency-data/BaselineLAT999.csv"
input_file_nf_chain_latency_reframer = "latency-data/Reframer-mergedLAT999.csv"

### Margins
bm_bottom = 0.137
tm_bottom = 0.21
bm_top = 0.26
tm_top = 0.984
lm = 0.115
rm = 0.99

# Set the x-axis cut points
set arrow from screen lm-0.008,tm_bottom+0.015 to screen lm+0.012,tm_bottom+0.040 nohead linewidth 3
set arrow from screen lm-0.003,tm_bottom+0.010 to screen lm+0.017,tm_bottom+0.035 nohead linewidth 3
set arrow from screen rm-0.017,tm_bottom+0.015 to screen rm+0.003,tm_bottom+0.040 nohead linewidth 3
set arrow from screen rm-0.012,tm_bottom+0.010 to screen rm+0.008,tm_bottom+0.035 nohead linewidth 3

set multiplot layout 1,2 columnsfirst upwards

####### Plot 1
x1 = x_start
x2 = max_buf_time + x_offset
y1 = min_y_bot
y2 = max_y_bot

### Margins
set bmargin at screen bm_bottom
set tmargin at screen tm_bottom
set lmargin at screen lm
set rmargin at screen rm

### Border
set border 1+2+8 lw 2

### X-axis
set xlabel "Buffering time (μs)"
set xlabel font font_type_bold
set xlabel offset 0,0.2
set xrange [x1:x2]
set xtics nomirror 16

### Y-axis
set yrange [y1:y2]
set ytics mirror 10

### Grid
set grid xtics lw 3.0 lt 0
set grid ytics lw 3.0 lt 0

### Legend
unset key

### No data here
plot \
	1/0 ls 6 dt 4 notitle

####### Plot 2
x1 = x_start
x2 = max_buf_time + x_offset
y3 = min_y_top
y4 = max_y_top

### Margins
set bmargin at screen bm_top
set tmargin at screen tm_top
set lmargin at screen lm
set rmargin at screen rm

### Border
set border 2+4+8 lw 2

### X-axis
unset xlabel
unset xtics
set x2tics border in scale 1,0.5 norotate autojustify nomirror
set x2range [x1:x2]
set x2tics nomirror 16

### Y-axis
set ylabel "{/Helvetica:Bold 99.9th Latency (μs)}"
set ylabel offset 0.4,-0.5
set ytics border in scale 1,0.5 norotate mirror
set ytics 100
set yrange [y3:y4]

### Grid
set grid x2tics lw 3.0 lt 0
set grid y2tics lw 3.0 lt 0

### Legend
set key outside opaque bottom Right title
set key box linestyle 1 lt rgb(black)
set key font font_type
set key vertical maxrows 3
set key width 0.0
set key height 0.67
set key samplen 3.0
set key at 245, 900

### Linestyles
set style line 1 pointtype 4 pointsize points_size linewidth points_lw lt rgb(black)
set style line 2 pointtype 3 pointsize points_size linewidth points_lw lt rgb(darkred)
set style line 3 pointtype 6 pointsize points_size linewidth points_lw lt rgb(darkgreen)
set style line 4 pointtype 8 pointsize points_size linewidth points_lw lt rgb(darkyellow)

### Arrows and label to highlight the improvement
set arrow heads back filled from 64,1144 to 64,1561 ls 1 linewidth 3
set label '-26%' at 65,1350 textcolor ls 1

plot \
	input_file_nf_chain_latency_baseline using ($1):($4):($3):($5) with errorbars ls 1 title "Baseline",\
	input_file_nf_chain_latency_reframer using ($1):($4):($3):($5) with errorbars ls 2 title "With Reframer"

unset multiplot
