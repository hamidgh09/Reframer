#!/usr/bin/gnuplot
load "../../common.plot"

font_type = "Helvetica,28"
font_type_bold = "Helvetica-Bold,28"

set terminal pdf dl 1.5 enhanced dashed size 10.0, 5.5 font font_type
set output "ovs-dpdk-mlnx-cx5-rulebench-cascade-table-0-latency-box-max.pdf"

### Variables
bw = 0.7
fill_solid = 3
points_lw = 3
points_size = 3
line_width = 3
y_scale_ms = 1000
min_lat_bot = 0
max_lat_bot = 0.15
min_lat_top = 0.070
max_lat_top = 0.122

set boxwidth bw
set style data candlesticks
set pointsize 3
set style fill pattern border -1
set datafile separator ' '

### Input files
input_file_rules_10000_match_first_lat_max  = "data/dpdk/tcp/pktlen-1500/rules-10000/Rule_Position__firstLAT-MAX.csv"
input_file_rules_20000_match_first_lat_max  = "data/dpdk/tcp/pktlen-1500/rules-20000/Rule_Position__firstLAT-MAX.csv"

### Margins
bm_bottom = 0.131
tm_bottom = 0.21
bm_top = 0.26
tm_top = 0.995
lm = 0.0975
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
y1 = min_lat_bot
y2 = max_lat_bot

# Margins
set bmargin at screen bm_bottom
set tmargin at screen tm_bottom
set lmargin at screen lm
set rmargin at screen rm

# Leave the right border open
set border 1+2+8 lw 2

# X-axis
set xlabel "Interleave factor"
set xlabel font font_type_bold
set xlabel offset 0,0.41
set xrange [x1:x2]
set xtics nomirror
set xtics ("1" 1, "4" 4, "8" 8, "12" 12, "16" 16, "20" 20, "24" 24, "28" 28, "32" 32)

# Y-axis
set yrange [y1:y2]
set ytics nomirror 0.5
set ytics ("0" 0, "" 0.15)

# Grid
set grid xtics lw 3.0 lt 0
set grid ytics lw 3.0 lt 0

# Legend
unset key

# Area marking
set style rect fc lt -1 fs solid 0.05 noborder
set obj rect from 02.0, graph 0.0 to 06.0, max_lat_bot fs solid 0.15 fc rgb "#002233" lw 0 behind
set obj rect from 10.0, graph 0.0 to 14.0, max_lat_bot fs solid 0.15 fc rgb "#002233" lw 0 behind
set obj rect from 18.0, graph 0.0 to 22.0, max_lat_bot fs solid 0.15 fc rgb "#002233" lw 0 behind
set obj rect from 26.0, graph 0.0 to 30.0, max_lat_bot fs solid 0.15 fc rgb "#002233" lw 0 behind

# No data here
plot \
	1/0 ls 6 dt 4 notitle

####### Plot 2
x1 = -1.5
x2 = 34
y3 = min_lat_top
y4 = max_lat_top

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
set x2range [x1:x2]
set x2tics mirror
set x2tics ("" 1, "" 4, "" 8, "" 12, "" 16, "" 20, "" 24, "" 28, "" 32)

# Y-axis
set ylabel "{/Helvetica:Bold Maximum Latency ({/Symbol m}s)}"
set ylabel offset -0.1,-0.9
set ytics border in scale 1,0.5 norotate mirror
set ytics nomirror 0.010
set ytics ("30" 0.030, "40" 0.040, "50" 0.050, "60" 0.060, "70" 0.070, "80" 0.080, "90" 0.090, "100" 0.100, "110" 0.110, "120" 0.120)
set yrange [y3:y4]

# Grid
set grid x2tics lw 3.0 lt 0
set grid y2tics lw 3.0 lt 0

# Area marking
set style rect fc lt -1 fs solid 0.05 noborder
set obj rect from 02.0, graph 0.0 to 06.0, max_lat_top fs solid 0.15 fc rgb "#002233" lw 0 behind
set obj rect from 10.0, graph 0.0 to 14.0, max_lat_top fs solid 0.15 fc rgb "#002233" lw 0 behind
set obj rect from 18.0, graph 0.0 to 22.0, max_lat_top fs solid 0.15 fc rgb "#002233" lw 0 behind
set obj rect from 26.0, graph 0.0 to 30.0, max_lat_top fs solid 0.15 fc rgb "#002233" lw 0 behind

# Legend
#unset key

# Legend
set key outside opaque bottom Right title
set border back
set key box linestyle 1 lt rgb(black)
set key font ",28.0"
set key vertical maxrows 2
set key width 0.0
set key height 0.5
set key samplen 1.5
set key at 20.5, 0.0635

### Linestyles
set style line 1  pointtype 4  pointsize points_size linewidth points_lw lt rgb(darkgreen)
set style line 2  pointtype 6  pointsize points_size linewidth points_lw lt rgb(darkyellow)
set style line 3  pointtype 6  pointsize points_size linewidth points_lw lt rgb(darkblue)
set style line 4  pointtype 8  pointsize points_size linewidth points_lw lt rgb(red)

plot \
	input_file_rules_10000_match_first_lat_max	every ::0::0 using ($1-bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 2 lw 1 title "10k Rules" fill pattern 3 whiskerbars 0.4,\
	""											every ::0::0 using ($1-bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_20000_match_first_lat_max	every ::0::0 using ($1+bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 3 lw 1 title "20k Rules" fill pattern 2 whiskerbars 0.4,\
	""											every ::0::0 using ($1+bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 3 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_max	every ::3::3 using ($1-bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 2 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::3::3 using ($1-bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_20000_match_first_lat_max	every ::3::3 using ($1+bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 3 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::3::3 using ($1+bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 3 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_max	every ::7::7 using ($1-bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 2 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::7::7 using ($1-bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_20000_match_first_lat_max	every ::7::7 using ($1+bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 3 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::7::7 using ($1+bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 3 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_max	every ::11::11 using ($1-bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 2 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::11::11 using ($1-bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_20000_match_first_lat_max	every ::11::11 using ($1+bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 3 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::11::11 using ($1+bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 3 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_max	every ::15::15 using ($1-bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 2 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::15::15 using ($1-bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_20000_match_first_lat_max	every ::15::15 using ($1+bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 3 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::15::15 using ($1+bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 3 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_max	every ::19::19 using ($1-bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 2 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::19::19 using ($1-bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_20000_match_first_lat_max	every ::19::19 using ($1+bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 3 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::19::19 using ($1+bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 3 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_max	every ::23::23 using ($1-bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 2 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::23::23 using ($1-bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_20000_match_first_lat_max	every ::23::23 using ($1+bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 3 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::23::23 using ($1+bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 3 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_max	every ::27::27 using ($1-bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 2 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::27::27 using ($1-bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_20000_match_first_lat_max	every ::27::27 using ($1+bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 3 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::27::27 using ($1+bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 3 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_max	every ::31::31 using ($1-bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 2 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::31::31 using ($1-bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_20000_match_first_lat_max	every ::31::31 using ($1+bw/2):($3/y_scale_ms):($2/y_scale_ms):($6/y_scale_ms):($5/y_scale_ms) with candlesticks ls 3 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::31::31 using ($1+bw/2):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms):($4/y_scale_ms) with candlesticks ls 3 lw 1 notitle

unset multiplot
