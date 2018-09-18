#!/usr/bin/perl  -w
use cPanelUserConfig;

use CGI;
use CGI::Carp qw(fatalsToBrowser);
use DBI;

my $q = CGI->new;

my $dsn = "DBI:mysql:registrants:localhost";
my $dbh = DBI->connect($dsn,'akohag','Redwings4030', {RaiseError => 1, PrintError => 1}) or die "$DBI::errstr";

my $sth = $dbh->prepare("SELECT first_name, last_name, address1, address2, city, state, zip, country, date FROM registrants") or die "$!";
$sth->execute();

print $q->header;

print $q->start_html();
print "<table style=\"border: 1px solid black;border-collapse: collapse;width: 100%;\">\n";
print "<tr style=\"background-color: #97bbf4; color: #FFF;\"><th style=\"text-align: center;\">First Name</th><th style=\"text-align: center;\">Last Name</th><th style=\"text-align: center;\">Address1</th><th style=\"text-align: center;\">Address2</th><th style=\"text-align: center;\">City</th><th style=\"text-align: center;\">State</th><th style=\"text-align: center;\">Zip Code</th><th style=\"text-align: center;\">Country</th><th style=\"text-align: center;\">Date</th></tr>\n";

my @ary;


while (@ary = $sth->fetchrow_array ())
{
    print "  <tr style=\"border: 1px solid black;\">\n";
    foreach(@ary)
    {
        print "    <td style=\"text-align: center;\">$_</td>\n";
    }
    print "  </tr>\n";
}
print "</table>\n";
print end_html;

$sth->finish();
$dbh->disconnect;
