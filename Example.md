Datathon for Social Good 2020 - Community Hubs Australia
================
Little Big Stories
30/03/2020

## Introduction

This is an R Markdown report for Community Hubs Australia. The report
was written and compiled for the Datathon for Social Good 2020.

I would like to acknowledge the time and effort our mentor, Ilana
Lichtenstein spent assisting in the implementation of the R code used
for the time series.

To keep the identities of the hubs and their community participants
secure the data was anonymized, before we received it. Because the data
is anonymized there are several obvious but interesting questions we
were unable to ask, including, but not limited to; how does the location
of a hub affect community participation? How many of the community hub
participants return? What is the average number of visits for a family?

The question this report lays the foundation to ask is; Is there a
relationship between the number of days a community hub is active each
quarter and any of the other recorded variables? The report contains a
time series which visualises the number of days each hub has been
active, per quarter, since Community Hubs Australia opened in 2016. An
active day has been defined as a day on which at least one activity was
recorded, with at least one participant.

## Data cleaning

The data provided by Community Hubs Australia was raw. The data cleaning
that was undertaken reduced the original dataset from 163,150
observations of 31 variables, down to 41,268 of 14 variables. A large
portion of the data points removed were referrals or observations with 0
participants. Referalls and observations for each hub have been
summarized in the Power BI dashboard that accomponies this report. .

Since opening in 2016 community hubs have been active for 430 days.

The histogram shows that 1 to 4 days per month are the most frequebtly
recorded active days per hub. The recorded frequency of 5+ days per
month is much lower and has an almost uniform distribution. The lack of
variability showed us that doing a time series on the active days each
month, in each hub will not show much growth or change. We decided to
instead run the time series analysis on the number of active days per
quarter.

![](Example_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

\#\#Time series visualization

The first plot below, plots the active days per quarter for all hubs.

![](Example_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

The plot below shows an example how you can plot a small number of hubs
against each other. This could be useful if trying to determine if a hub
is growing at the same rate as other hubs that share similar
charachteristics (e.g. location, socio-econmic status, population)

``` r
ggplot(df %>% filter(series==11227 | series==11491), aes(time,value)) + geom_line(aes(colour = series))
```

![](Example_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

The following eight plots visualise the activity of all hubs across the
lifetime of Community Hubs Australia. Each one contains the time series
of 5 random hubs plotted against each other.

Across many of the 80 hubs, there are two distinguishing features in the
time series plots. The first is that before mid-2018 active hubs
typically opened for ten days a quarter with no year on year growth rate
apparent. The second is a sharp increase in activity in mid-2018 which
then falls again quickly.

Further analysis of the time series could ask questions including how
does the number of days that a hub is open per quarter effect referral
numbers, the participation of adults and children, and compare the
amount of activity at a hub to external data such as feelings of
community safety, bullying, improvement in childhood outcomes.

![](Example_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->![](Example_files/figure-gfm/unnamed-chunk-7-2.png)<!-- -->![](Example_files/figure-gfm/unnamed-chunk-7-3.png)<!-- -->![](Example_files/figure-gfm/unnamed-chunk-7-4.png)<!-- -->![](Example_files/figure-gfm/unnamed-chunk-7-5.png)<!-- -->![](Example_files/figure-gfm/unnamed-chunk-7-6.png)<!-- -->![](Example_files/figure-gfm/unnamed-chunk-7-7.png)<!-- -->![](Example_files/figure-gfm/unnamed-chunk-7-8.png)<!-- -->
