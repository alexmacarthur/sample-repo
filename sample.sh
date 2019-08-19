while read oldrev newrev ref
do
    # Location of our bare repository.
    GIT_DIR="/home/neat-app-repo"

    # Where we want to copy our code.
    TARGET="/home/neat-app-deployed"

    # Neat trick to get the branch name of the reference just pushed:
    BRANCH=$(git rev-parse --symbolic --abbrev-ref $ref)

    if [[ "$BRANCH" = "master" ]];
    then
        # Send a nice message to the machine pushing to this remote repository.
        echo "Push received! Deploying branch: ${BRANCH}..."
        
        # "Deploy" the branch we just pushed to a specific directory.
        git --work-tree=$TARGET --git-dir=$GIT_DIR checkout -f $BRANCH
    else 
        echo "Not master branch. Skipping."
    fi
done
