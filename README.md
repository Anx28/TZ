https://github.com/Anx28/TZ/blob/main/github-workflows -
Task 2: GitHub Actions Workflow for Automated Deployment 
Objective:
Create a GitHub Actions workflow that, on every commit to the main branch, deploys all files from the repository’s main branch to a remote server via FTP and updates a VERSION.txt file with the current commit info.

Requirements:

Trigger on commit to main.
Deploy via FTP using credentials stored as GitHub Actions secrets.
Update VERSION.txt with the latest commit info and current branch.

---
analyze-deb.sh

Bash Script to Analyze .deb Files 
Objective:
Write a Bash script that, given a .deb file, extracts and displays the package name and its dependencies in a readable format.

Requirements:

The script should accept the .deb file path as a command-line argument.
Output the package name and a list of dependencies.
Usage Example:

./analyze-deb.sh package.deb

---

