# Getting and Cleaning Data: Project

This repo contains my solution for the course "Getting and Cleaning Data".
The goal of the project is to generate a tidy data set, based on the original data from
the "[Human Acitvity Recognition Using Samrtphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)" study.

## Data
The study provides a train and test dataset, with the following details:
* Subject - a number to identify an invidiual in the research (1 ~ 30)
* Activity - an activity performed by the Subject (Walking, Standing, etc.)
* Measurements - a list of measured parameters for each activity and subject (@see: Codebook.md for details)

In this project, we're only interested in Mean and Standard Deviation of the measurements.

## Solution
The R-script [run_analysis.R](https://github.com/amirbehzad/coursera-getdata/blob/master/run_analysis.R) is written to parse the original data files, and generate a summarized version of it in a tidy format.  It follows the following steps in order to achive the goal:

1. Initilization (loading packages, etc.)
2. Function definitions
3. Load feature list for measurements
4. Convert the feature list into R-friendly column names
5. Load activity ids and labels
6. Load Measurements, Subjects, and Activity for Train and Test data
7. Extract only columns that are Mean and Standard Deviation
8. Merge Measurements, Subjects, and Activity together
9. Merge Train and Test data
10. Summarize
11. Generate the output file

