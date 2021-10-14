#!/usr/bin/gnuplot
load "../../common.plot"

font_type = "Helvetica,28"
font_type_bold = "Helvetica-Bold,28"

set terminal pdf dl 1.5 enhanced dashed size 10.0, 4.5 font font_type
set output "nf-chain-cascade-l1-misses.pdf"

set style fill solid 2 border lt -1
set datafile separator " "
set style data errorbars

### Variables
points_lw = 3
points_size = 2.0
line_width = 2

max_ordering = 32
x_start = 0.0
x_offset = 1.5
min_y = 0
### Per batch limit (1 batch = 32 packets)
#max_y = 45
### Per packet limit
max_y = 57
y_scale = 1    # Converts per batch into per packet cost

### Input files
input_file_nf_chain_misses = "data/MISSES-PP2.csv"

### Margins
bm = 0.160
tm = 0.984
lm = 0.08
rm = 0.995

x1 = -1.5
x2 = 34
y3 = min_y
y4 = max_y

# Margins
set bmargin at screen bm
set tmargin at screen tm
set lmargin at screen lm
set rmargin at screen rm

# Leave the right border open
set border 1+2+4+8 lw 2

# X-axis
set xlabel "Spatial locality factor"
set xlabel font font_type_bold
set xlabel offset 0,0.41
set xrange [x_start:max_ordering + x_offset]
set xtics mirror 2

# Y-axis
set ylabel "{/Helvetica:Bold L1 misses per packet}"
set ylabel offset 1.1,0.0
set ytics border in scale 1,0.5 norotate
set ytics mirror 5
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
set key at 30, 8

### Linestyles
set style line 1 pointtype 3 pointsize points_size linewidth points_lw lt rgb(darkred)
set style line 2 pointtype 4 pointsize points_size linewidth points_lw lt rgb(darkblue)
set style line 3 pointtype 6 pointsize points_size linewidth points_lw lt rgb(darkgreen)

# Arrows and label to highlight the improvement
set arrow heads back filled from 32.7,17.6 to 32.7,53.5 ls 1 linewidth 3
set label '>2x' at 30.4,32.5 textcolor ls 1
set arrow nohead from 1.3,53.5 to 32.4,53.5 ls 1 linewidth 3 dt 2

plot \
	input_file_nf_chain_misses using ($1):($4):($3):($5) with errorbars ls 1 title "Router {/Symbol=28 \256} NAT {/Symbol=28 \256} Firewall {/Symbol=28 \256} FC Service Chain"
