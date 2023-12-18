#!/bin/bash

# Check if today is the 25th of the month
if [ "$(date +\%d)" -eq "18" ]; then

    # Format the date as dd/mm/yyyy
    today_date=$(date +\%d/\%m/\%Y)

    # Step 1: Create a release branch
    git checkout -b release-${today_date}

    # Step 2: Make necessary changes for the release
    # Update version numbers, changelog, etc.

    # Step 3: Commit changes
    git add .
    git commit -m "Prepare for release ${today_date}"

    # Step 4: Create a tag for the release
    git tag -a v${today_date} -m "Release version ${today_date}"

    # Step 5: Push the branch and tags to the remote repository
    git push origin release-${today_date}
    git push origin v${today_date}

    # Step 6: Merge changes back to the main development branch (e.g., master)
    git checkout master
    git merge release-${today_date}

    # Step 7: Push changes to the remote repository
    git push origin master

    # Optionally, delete the release branch locally and remotely
    git branch -d release-${today_date}
    git push origin --delete release-${today_date}

else
    echo "Not the 25th of the month. No release will be performed."
fi
