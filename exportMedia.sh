#!/usr/bin/env bash

# get picture from google storage
echo "------ Get folder from Google Storage : BEGIN ------"
gsutil -m cp -r -a public-read "gs://<bucket-name>/$1"/ .
echo "------ Get folder from Google Storage : END ------"

# if we want to move all media in the samefolder
echo "------ Prepare folder for transfer : BEGIN ------"
for f in "$1"/*;
        do
                mv "<bucket-name>/$f"/* "<bucket-name>/$1"
                rmdir "<bucket-name>/$f"
        done;
echo "------ Prepare folder for transfer : END ------"

# zip folder
echo "------ Zip folder : BEGIN ------"
zip -r "$1".zip $1
echo "------ Zip folder : END ------"

#send zipped file to google storage
echo "------ Send folder to Google storage : BEGIN ------"
gsutil cp -r -a public-read ./"$1".zip  gs://<bucket-name>/temp/export/media/
echo "------ Send folder to Google storage : END ------"

# delete folder and zip
echo "------ Clean Local : BEGIN ------"
rm -rf ./"$1".zip
rm -rf ./"$1"
echo "------ Clean Local : END ------"
echo "file url : https://storage.googleapis.com/<bucket-name>/temp/export/media/$1".zip
