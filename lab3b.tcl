set ns [new Simulator]
set nf [open lab3b.nam w]

$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n0 $n1 1Mb 8ms DropTail
$ns duplex-link $n0 $n2 1Mb 8ms DropTail

set tcp1 [new Agent/TCP]
set tcp2 [new Agent/TCP]

$ns attach-agent $n0 $tcp1
$ns attach-agent $n0 $tcp2

set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1

set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2

$ns connect $tcp1 $sink1
$ns connect $tcp2 $sink2

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

proc finish {} {
	global ns nf
	$ns flush-trace
	close $nf
	exec nam lab3b.nam &
	exit 0
}

$ns at 0.1ms "$ftp1 start"
$ns at 0.1ms "$ftp2 start"
$ns at 4ms "finish"
$ns run 
