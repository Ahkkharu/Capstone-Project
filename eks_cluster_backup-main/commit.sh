#!bin/bash

#this pulls the latest code, adds lines to the readme file and pushes it 
git pull 
echo "a bit of resolution" >> /home/ec2-user/eks_cluster_setup/3.tools_setup/README.md
git add .
git commit -m "cleaning up the code"
git push origin master
sleep 2

# this adds more lines to the readme file 
echo "clean again" >> /home/ec2-user/eks_cluster_setup/3.tools_setup/README.md
git add .
git commit -m "removing last comment from readme.md"
git push origin master
sleep 2

# this removes the lines that were created 
sed -i '38,49d' /home/ec2-user/eks_cluster_setup/3.tools_setup/README.md
git add .
git commit -m "removing last comment from readme.md"
git push origin master
sleep 2