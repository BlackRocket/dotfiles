#!/usr/bin/perl
 
use strict;
use warnings;
use LWP;
use WWW::Mechanize;
use Getopt::Std;
use Data::Dumper;
 

###########################################################################
## input parameters and configuration
###########################################################################
$| = 1;

my $thread = shift or die "no thread supplied\n";

my %opts;
getopts('ar:b:', \%opts);
my (    $archive, 
        $board,
        ) =                 @opts{'a', 'b'};

$board =    $board || 'p';
my $url =   'http://boards.4chan.org/' . $board . '/res/' . $thread;

my $ua_string = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0a2) Gecko/20111101 Firefox/9.0a2';
my $browser = LWP::UserAgent->new();
$browser->agent($ua_string);

my $mech = WWW::Mechanize->new();
$mech->agent_alias('Mac Mozilla');
###########################################################################


###########################################################################
## get timestamp for directory name
###########################################################################
my ($sec, $min, $hour, $mday, $mon, $year) = localtime;
$mon++;

$min =  substr('0'.$min,    -2, 2);
$hour = substr('0'.$hour,   -2, 2);
$mday = substr('0'.$mday,   -2, 2);
$mon =  substr('0'.$mon,    -2, 2);
$year = substr($year,        1, 2);

my $datestamp = $year.$mon.$mday.$hour.$min;

# Make a directory for the images
my $directory = $board . '_' . $datestamp . '_' . $thread; 
mkdir $directory, 0755 unless -e $directory;
###########################################################################


###########################################################################
## create list of threads to run
###########################################################################
my $threadlist = [];

push @$threadlist, {  
        'datestamp' => $datestamp, 
        'board'     => $board,
        'thread'    => $thread, 
        'directory' => $directory,
        'url'       => 'http://boards.4chan.org/' . $board . '/res/' . $thread,
        };

if ($archive){
    my @threadlist = glob('*');
    foreach my $threadname (@threadlist){
        if (-d $threadname and $threadname =~ /^[a-z]{1,4}_\d+_\d+$/i){
            my ($board, $datestamp, $thread) = ($threadname =~ /([a-z]{1,4})_(\d+)_(\d+)/i);
            push @$threadlist, {  
                'datestamp' =>  $datestamp, 
                'board'     =>  $board,
                'thread'    =>  $thread, 
                'directory' =>  $threadname,
                'url' =>        'http://boards.4chan.org/' . $board . '/res/' . $thread,
                };
        }
    }
}

print Dumper($threadlist);
###########################################################################

my $run_counter = 1;
 
# Run until canceled
run() while 1;
 

##########################################################
# if url exists and has content, write contents to thread directory
#   and return content
# otherwise return 0
##########################################################
sub get_content {
    my ($url, $thread, $directory) = @_;
 
    ##########################################################
    # get content
    ##########################################################
    my $response = $browser->get($url);
    my $content = $response->content;
    
    return 0 if not $response->is_success;
 
    ##########################################################
    # write thread html to a file
    ##########################################################
    open my $cont, ">:utf8", "$directory\/$thread.html";
    print {$cont} $content;
    close $cont;
 
    return $content;
}
##########################################################

 
##########################################################
# if thread exists and has content, download images and return 1
# otherwise exit and return 0 
##########################################################
sub run_thread {
    my $thread_ref = shift;

    return 0 unless ($thread_ref->{'url'} =~ /http:\/\/boards.4chan.org\/[A-Z]{1,4}\/res\/(\d+)/i);
 
    my $content = get_content($thread_ref->{url}, $thread_ref->{thread}, $thread_ref->{directory});
 
    return 0 if not $content;

    foreach my $image_link ($content =~ /"(\/\/[^\/]*\/[A-Z]{1,4}\/src\/\d+\.(?:jpg|png|gif))"/gsim){
        if  ($image_link =~ /(\/\/[^\/]*\/[A-Z]{1,4}\/src\/(\d+\.(jpg|png|gif)))/i) {
            if (not -e $thread_ref->{directory}."\/$2"){
                eval {$mech->get('http:'.$1, ":content_file"=>$thread_ref->{directory}."\/$2") unless -e $thread_ref->{directory}."\/$2"};
                warn $@ if $@;
                print "downloaded ", $thread_ref->{directory}."\/$2", "\n";
            }
        }
    }
    return 1;
} 
##########################################################
 

##########################################################
# loop through array of threads and call run_thread() to 
#   download images
# if thread does not exist or does not have content,
#   remove thread from threadlist so it's not
#   considered for next iteration
##########################################################
sub run {
    $run_counter++;

    print "thread count:  ", scalar @$threadlist, "\n";
    my $new_threadlist = [];
    foreach my $thread_ref (@$threadlist){
        my $status = run_thread($thread_ref);
        print "status:  $status\n";
        push (@$new_threadlist, $thread_ref) if ($status == 1);
    }

    $threadlist = $new_threadlist;

    print "Wait 1 minute before run #", $run_counter, "\n";
    sleep(60);
    print "\n";
} 
##########################################################