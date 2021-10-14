#!/usr/bin/gnuplot
load "../../common.plot"

font_type = "Helvetica,28"
font_type_bold = "Helvetica-Bold,28"

set terminal pdf dl 1.5 enhanced dashed size 10.0, 5.5 font font_type
set output "ovs-kernel-mlnx-cx5-rulebench-cascade-table-0-latency-p75.pdf"

### Variables
bw = 0.7
fill_solid = 3
points_lw = 3
points_size = 2
line_width = 3
y_scale = 1000
min_lat_bot = 0
max_lat_bot = 0.010
min_lat_top = 0.040
max_lat_top = 0.350

set boxwidth bw
set pointsize 3
set style fill pattern border -1
set datafile separator ' '

### Input files
input_file_rules_1000_match_first_lat_p75  = "data/kernel/udp/pktlen-1500/rules-1000/LAT-P75.csv"
input_file_rules_10000_match_first_lat_p75 = "data/kernel/udp/pktlen-1500/rules-10000/LAT-P75.csv"

### Margins
bm_bottom = 0.126
tm_bottom = 0.21
bm_top = 0.26
tm_top = 0.985
lm = 0.096
rm = 0.99

# Set the x-axis cut points
set arrow from screen lm-0.008,tm_bottom+0.015 to screen lm+0.012,tm_bottom+0.040 nohead linewidth 3
set arrow from screen lm-0.003,tm_bottom+0.010 to screen lm+0.017,tm_bottom+0.035 nohead linewidth 3
set arrow from screen rm-0.017,tm_bottom+0.015 to screen rm+0.003,tm_bottom+0.040 nohead linewidth 3
set arrow from screen rm-0.012,tm_bottom+0.010 to screen rm+0.008,tm_bottom+0.035 nohead linewidth 3

set multiplot layout 1,2 columnsfirst upwards

####### Plot 1
x1 = -1.0
x2 = 33.5
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
set xlabel "Spatial locality factor"
set xlabel font font_type_bold
set xlabel offset 0,0.41
set xrange [x1:x2]
set xtics nomirror
set xtics ("1" 1, "4" 4, "8" 8, "12" 12, "16" 16, "20" 20, "24" 24, "28" 28, "32" 32)

# Y-axis
set yrange [y1:y2]
set ytics mirror 0.01
set ytics ("0" 0, "10" 0.01)

# Grid
set grid xtics lw 3.0 lt 0
set grid ytics lw 3.0 lt 0

# Legend
unset key

# Area marking
#set style rect fc lt -1 fs solid 0.05 noborder
#set obj rect from 02.0, graph 0.0 to 06.0, max_lat_bot fs solid 0.15 fc rgb "#002233" lw 0 behind
#set obj rect from 10.0, graph 0.0 to 14.0, max_lat_bot fs solid 0.15 fc rgb "#002233" lw 0 behind
#set obj rect from 18.0, graph 0.0 to 22.0, max_lat_bot fs solid 0.15 fc rgb "#002233" lw 0 behind
#set obj rect from 26.0, graph 0.0 to 30.0, max_lat_bot fs solid 0.15 fc rgb "#002233" lw 0 behind

# No data here
plot \
	1/0 ls 6 dt 4 notitle

####### Plot 2
x1 = -1.0
x2 = 33.5
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
set x2tics border in scale 1,0.5 norotate autojustify
set x2range [x1:x2]
set x2tics nomirror
set x2tics ("" 1, "" 4, "" 8, "" 12, "" 16, "" 20, "" 24, "" 28, "" 32)

# Y-axis
set ylabel "{/Helvetica:Bold Latency (μs)}"
set ylabel offset -0.3,-0.9
set ytics border in scale 1,0.5 norotate mirror
set ytics mirror
set ytics ("50" 0.050, "100" 0.100, "150" 0.150, "200" 0.200, "250" 0.250, "300" 0.300, "350" 0.350, "400" 0.400, "450" 0.450, "500" 0.500, "550" 0.550)
set yrange [y3:y4]

# Grid
set grid x2tics lw 3.0 lt 0
set grid y2tics lw 3.0 lt 0

# Area marking
#set style rect fc lt -1 fs solid 0.05 noborder
#set obj rect from 02.0, graph 0.0 to 06.0, max_lat_top fs solid 0.15 fc rgb "#002233" lw 0 behind
#set obj rect from 10.0, graph 0.0 to 14.0, max_lat_top fs solid 0.15 fc rgb "#002233" lw 0 behind
#set obj rect from 18.0, graph 0.0 to 22.0, max_lat_top fs solid 0.15 fc rgb "#002233" lw 0 behind
#set obj rect from 26.0, graph 0.0 to 30.0, max_lat_top fs solid 0.15 fc rgb "#002233" lw 0 behind

# Legend
set key outside opaque bottom Right title
set border back
set key box linestyle 1 lt rgb(black)
set key font font_type
set key vertical maxrows 4
set key width -7.2
set key height 0.5
set key samplen 2
set key at 32.8, 0.280

### Linestyles
set style line 1 pointtype 6 pointsize points_size linewidth points_lw lt rgb(darkred)
set style line 2 pointtype 5 pointsize points_size linewidth points_lw lt rgb(darkblue)
set style line 3 pointtype 7 pointsize points_size linewidth points_lw lt rgb(darkgreen)
set style line 4 pointtype 8 pointsize points_size linewidth points_lw lt rgb(darkyellow)

plot \
	input_file_rules_10000_match_first_lat_p75	every ::0::0 using ($1+bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 2 lw 1 title "75^{th} latency percentile - 10000 rules" fill pattern 2 whiskerbars 0.4,\
	""											every ::0::0 using ($1+bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_1000_match_first_lat_p75	every ::0::0 using ($1-bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 1 lw 1 title "75^{th} latency percentile -   1000 rules" fill pattern 3 whiskerbars 0.4,\
	""											every ::0::0 using ($1-bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 1 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_p75	every ::1::1 using ($1+bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 2 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::1::1 using ($1+bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_1000_match_first_lat_p75	every ::1::1 using ($1-bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 1 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::1::1 using ($1-bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 1 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_p75	every ::2::2 using ($1+bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 2 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::2::2 using ($1+bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_1000_match_first_lat_p75	every ::2::2 using ($1-bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 1 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::2::2 using ($1-bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 1 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_p75	every ::3::3 using ($1+bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 2 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::3::3 using ($1+bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_1000_match_first_lat_p75	every ::3::3 using ($1-bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 1 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::3::3 using ($1-bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 1 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_p75	every ::4::4 using ($1+bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 2 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::4::4 using ($1+bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_1000_match_first_lat_p75	every ::4::4 using ($1-bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 1 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::4::4 using ($1-bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 1 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_p75	every ::5::5 using ($1+bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 2 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::5::5 using ($1+bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_1000_match_first_lat_p75	every ::5::5 using ($1-bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 1 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::5::5 using ($1-bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 1 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_p75	every ::6::6 using ($1+bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 2 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::6::6 using ($1+bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_1000_match_first_lat_p75	every ::6::6 using ($1-bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 1 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::6::6 using ($1-bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 1 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_p75	every ::7::7 using ($1+bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 2 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::7::7 using ($1+bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_1000_match_first_lat_p75	every ::7::7 using ($1-bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 1 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::7::7 using ($1-bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 1 lw 1 notitle,\
	\
	input_file_rules_10000_match_first_lat_p75	every ::8::8 using ($1+bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 2 lw 1 notitle fill pattern 2 whiskerbars 0.4,\
	""											every ::8::8 using ($1+bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 2 lw 1 notitle,\
	input_file_rules_1000_match_first_lat_p75	every ::8::8 using ($1-bw/2):($3/y_scale):($2/y_scale):($6/y_scale):($5/y_scale) with candlesticks ls 1 lw 1 notitle fill pattern 3 whiskerbars 0.4,\
	""											every ::8::8 using ($1-bw/2):($4/y_scale):($4/y_scale):($4/y_scale):($4/y_scale) with candlesticks ls 1 lw 1 notitle

unset multiplot
