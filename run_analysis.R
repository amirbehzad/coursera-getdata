library(plyr)

# returns a tidy version of the given labels
get_pretty_labels <- function(labels)
{
    labels <- make.names(labels, unique=T)
    labels <- gsub('(\\.+)', '.', labels)
    labels <- gsub('\\.$', '', labels)
    return (labels)
}

# from the given data-frame, extracts only the columns that contain mean or std
extract_meanstd_cols <- function(df)
{
    df[, grepl('(mean|std)\\.', names(df))]
}

# read the features, and convert them to tidy variable names
features <- read.table('features.txt', col.names=c('id', 'label'))
features <- get_pretty_labels(features$label)

# read the activity conversion map, and store it as a named vector
activity_map <- read.table('activity_labels.txt', col.names=c('id', 'label'))
activity_map <- setNames(activity_map$label, activity_map$id)

# read train dataset
train_measurements <- read.table('train/X_train.txt', col.names=measurement_labels)
train_subjects <- read.table('train/subject_train.txt', col.names=c('subject'))
train_activity <- read.table('train/y_train.txt', col.names=c('activity'), colClasses=c('factor'))

# read test dataset
test_measurements <- read.table('test/X_test.txt', col.names=measurement_labels)
test_subjects <- read.table('test/subject_test.txt', col.names=c('subject'))
test_activity <- read.table('test/y_test.txt', col.names=c('activity'), colClasses=c('factor'))

# remove extra columns from measurements
train_measurements <- extract_meanstd_cols(train_measurements)
test_measurements <- extract_meanstd_cols(test_measurements)

# combine data parts together
train <- cbind(train_measurements, train_subjects, train_activity)
test <- cbind(test_measurements, test_subjects, test_activity)

# combine dataset into one
data <- rbind(train, test)

# convert the activity IDs to their human-friendly value
data <- transform(data, activity = revalue(activity, activity_map))

# summarize the data
data_summary = aggregate(. ~ subject + activity, data = data, mean)

write.table(data_summary, file='summary.txt', row.name=FALSE)
