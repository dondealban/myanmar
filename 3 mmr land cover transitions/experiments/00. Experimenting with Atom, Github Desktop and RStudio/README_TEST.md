## README_TEST

**Creator:** J Johanness

**Date:** 18-09-2018

**Purpose:**

This will be a .md file detailing the procedures I have managed to complete in learning GitHub/RStudio/Atom

1. Managed to create a new folder within the repo within Atom
 - 1. Copy full path of folder (Ctrl+Shift+C)

 - 2. Right-click folder & paste the path

 - 3. Add at the end of the path 'README_TEST.md'

   -  Which creates the Markdown file in this folder

2. After ***Staging*** and then typing my GitHub useer ID and pw, the Commit was then ***Pushed*** to GitHub

 - The new folder and the .md file can now be seen on the repo that I am a Collaborator on.

 - **However**, I cannot see these lines of text yet.

 *Note:* There appears to be a bug where if any text in the repo path has a spacing in it, the unstaged changes may not show up in Atom window "Unstaged Changes".

 Link to this thread can be found [here](https://discuss.atom.io/t/git-unstaged-changes-not-showing-up/48337/13)

3. So, it is not that it does **NOT** show up, but rather within Atom, you have to go to File > Save, and then under your project window, all the files/folders where there were changes made, will be *Orange* in colour

 - Now it does appear on the Unstaged Changes window.

 - Attempting Staging and Pushing to the GitHub repo.

4. This final comment is done not in Atom, but in GitHub, signifying

  (1) the Push from Atom worked correctly

  (2) I can now see the code in the .md file

  (3) I am making these final comments to test if they show up on Atom after I push it from within GitHub

 5. So, after pushing from within GitHub, the current version in Atom, is the last version that was pushed from Atom to GitHub, so the changes in Point (4.) were not seen yet.

 - However at the bottom right, I clicked "Fetch", and then after fetching, there is 1 file that can be "Pull"-ed. After Pulling, only then can I see the changes made.

**Also**, while all these was being done, RStudio already has the .md file up to date, which suggests automatic updates, and not manually updating in Atom via Fetch > Pull, but maybe it takes some time, as although Point (4.) was already seen, the final comments after Point (5.) were still not yet showing in RStudio Project.

*And yes, the Pulling seems to be automatic. This line will be Staged and Pushed to GitHub via RStudio as a Commit.
You still **HAVE** to click the Green Push button in the Git Window within RStudio

**End**
