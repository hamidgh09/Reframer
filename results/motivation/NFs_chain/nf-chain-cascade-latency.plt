#!/usr/bin/gnuplot
load "../../common.plot"

font_type = "Helvetica,28"
font_type_bold = "Helvetica-Bold,28"

set terminal pdf dl 1.5 enhanced dashed size 10.0, 4.5 font font_type
set output "nf-chain-cascade-latency.pdf"

set style fill solid 2 border lt -1
set datafile separator " "
set style data errorbars

### Variables
points_lw = 3
points_size = 2.0
line_width = 2

max_ordering = 32.0
x_start = 0
x_offset = 1.5
min_y_bot = 0
max_y_bot = 10
min_y_top = 100
max_y_top = 505

### Input files
input_file_nf_chain_latency = "data/LATENCY2.csv"

### Margins
bm_bottom = 0.160
tm_bottom = 0.21
bm_top = 0.26
tm_top = 0.984
lm = 0.09
rm = 0.99

# Set the x-axis cut points
set arrow from screen lm-0.008,tm_bottom+0.015 to screen lm+0.012,tm_bottom+0.040 nohead linewidth 3
set arrow from screen lm-0.003,tm_bottom+0.010 to screen lm+0.017,tm_bottom+0.035 nohead linewidth 3
set arrow from screen rm-0.017,tm_bottom+0.015 to screen rm+0.003,tm_bottom+0.040 nohead linewidth 3
set arrow from screen rm-0.012,tm_bottom+0.010 to screen rm+0.008,tm_bottom+0.035 nohead linewidth 3

set multiplot layout 1,2 columnsfirst upwards

####### Plot 1
x1 = -1.5
x2 = 34
y1 = min_y_bot
y2 = max_y_bot

# Margins
set bmargin at screen bm_bottom
set tmargin at screen tm_bottom
set lmargin at screen lm
set rmargin at screen rm

# Leave the right border open
set border 1+2+8 lw 2

# X-axis
set xlabel "Spatial locality factor"
set xlabel font font_type_bold
set xlabel offset 0,0.41
set xrange [x_start:max_ordering + x_offset]
set xtics nomirror 2

# Y-axis
set yrange [y1:y2]
set ytics mirror 50

# Grid
set grid xtics lw 3.0 lt 0
set grid ytics lw 3.0 lt 0

# Legend
unset key

# No data here
plot \
	1/0 ls 6 dt 4 notitle

####### Plot 2
x1 = -1.5
x2 = 34
y3 = min_y_top
y4 = max_y_top

# Margins
set bmargin at screen bm_top
set tmargin at screen tm_top
set lmargin at screen lm
set rmargin at screen rm

# Leave the right border open
set border 2+4+8 lw 2

# X-axis
unset xlabel
unset xtics
set x2tics border in scale 1,0.5 norotate autojustify nomirror
set x2range [x_start:max_ordering + x_offset]
set x2tics nomirror 2

# Y-axis
set ylabel "{/Helvetica:Bold Latency (μs)}"
set ylabel offset 1.1,-0.5
set ytics border in scale 1,0.5 norotate mirror
set ytics mirror 50
set yrange [y3:y4]

# Grid
set grid x2tics lw 3.0 lt 0
set grid y2tics lw 3.0 lt 0

# Legend
set key outside opaque bottom Right title
set border back
set key box linestyle 1 lt rgb(black)
set key font ",28.0"
set key vertical maxrows 3
set key width -4.2
set key height 0.3
set key samplen 3.0
set key at 30, 320

### Linestyles
set style line 1 pointtype 3 pointsize points_size linewidth points_lw lt rgb(darkred)
set style line 2 pointtype 4 pointsize points_size linewidth points_lw lt rgb(darkblue)
set style line 3 pointtype 6 pointsize points_size linewidth points_lw lt rgb(darkgreen)

# Arrows and label to highlight the improvement
set arrow heads back filled from 32.7,124.1 to 32.7,432.2 ls 1 linewidth 3
set label '>3.5x' at 30,275 textcolor ls 1
set arrow nohead from 1.3,432.2 to 32.4,432.2 ls 1 linewidth 3 dt 2

plot \
	input_file_nf_chain_latency using ($1):($4):($3):($5) with errorbars ls 1 title "Router {/Symbol=28 \256} NAT {/Symbol=28 \256} Firewall {/Symbol=28 \256} FC Service Chain"

unset multiplot
