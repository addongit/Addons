!#/bin/sh

cd /data0/Code/nzeer.github.com/ui;

echo "***** Updating Addons";
eval `ssh-agent`
ssh-add

git checkout dev;

echo "***** Grabbing latest Decursive from upstream"
cd decursive;
git pull -s subtree Decursive master

echo "***** Commiting Decursive changes"
git add -v --all
git commit -a -s -m 'Auto-Merge of Decursive from upstream'
cd ../

echo "***** Grabbing latest Clique from upstream"
cd Clique;
git pull -s subtree Clique master

echo "***** Commiting Clique changes"
git add -v --all
git commit -a -s -m 'Auto-Merge of Clique from upstream'
cd ../

echo "***** Grabbing latest Bartender4 from upstream"
cd bartender4;
git pull -s subtree bartender4 master

echo "***** Commiting Bartender4 changes"
git add -v --all
git commit -a -s -m 'Auto-Merge of Bartender4 from upstream'
cd../

echo "***** Grabbing latest Omen from upstream"
cd omen;
git pull -s subtree Omen master

echo "***** Commiting Omen changes"
git add -v --all
git commit -a -s -m 'Auto-Merge of Omen from upstream'
cd ../

echo "***** Grabbing latest Archy from upstream"
cd Archy;
git pull -s subtree Archy master

echo "***** Commiting Archy changes"
git add -v --all
git commit -a -s -m 'Auto-Merge of Archy from upstream'
cd ../

echo "***** Grabbing latest Recount from SVN"
#rm -rf Recount/*
#rm -rf Recount/.*
#svn co svn+ssh://svn@svn.wowace.com/wow/recount/mainline/trunk Recount
cd Recount
svn up

echo "***** Commiting Recount changes"
git add -v --all
git commit -a -s -m 'Auto-Merge of Recount from upstream'
cd ../

echo "***** Grabbing latest AuctionLite from SVN"
#rm -rf AuctionLite/*
#rm -rf AuctionLite/.*
#svn co svn+ssh://svn@svn.wowace.com/wow/auctionlite/mainline/trunk AuctionLite
cd AuctionLite
svn up

echo "***** Commiting AuctionLite changes"
git add -v --all
git commit -a -s -m 'Auto-Merge AuctionLite from upstream'
cd ../

echo "***** Grabbing latest Skillet from SVN"
#rm -rf Skillet/*
#rm -rf Skillet/.*
#svn co svn+ssh://svn@svn.wowace.com/wow/skillet/mainline/trunk Skillet
cd Skillet
svn up 

echo "***** Commiting Skillet changes"
git add -v --all
git commit -a -s -m 'Auto-Merge Skillet from upstream'
cd ../

echo "***** Grabbing latest !BugGrabber from SVN"
#rm -rf \!BugGrabber/*
#rm -rf \!BugGrabber/.*
#svn co svn+ssh://svn@svn.wowace.com/wow/bug-grabber/mainline/trunk \!BugGrabber
cd \!BugGrabber
svn up

echo "***** Commiting !BugGrabber changes"
git add -v --all
git commit -a -s -m 'Auto-Merge !BugGrabber from upstream'
cd ../

echo "***** Grabbing latest Autobar from SVN"
cd Autobar
svn up

echo "***** Commiting Autobar changes"
git add -v --all
git commit -a -s -m 'Auto-Merge Autobar from upstream'
cd ../

echo "***** Grabbing latest Atlas from SVN"
cd Atlas
svn up

echo "***** Commiting Atlas changes"
git add -v --all
git commit -a -s -m 'Auto-Merge Atlas from upstream'
cd ../

echo "***** Grabbing latest DBM from SVN"
svn up

echo "***** Commiting DBM changes"
git add -v --all
git commit -a -s -m 'Auto-Merge DBM from upstream'

git checkout master
# make sure we have the up-to-date "origin" branches
git fetch origin
# # make sure the local "master" branch is up-to-date
git pull --rebase origin master

# merge the branch into the local "master" branch
git merge --log --no-ff dev
git log -1 # make sure you see a correct merge message (with summary), if not abort
git log ORIG_HEAD.. # make sure the commits shown are what you wanted to merge, if not abort
# gitk # optional, look if the commit tree looks ok
# # only if everything is ok and you looked at the log
# # push the changes on the local "master" branch to the repository "master" branch
git push origin master:master 


