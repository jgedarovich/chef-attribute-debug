SUBJECTS=(one-
two-
three-
four-
five-
six-
seven-
eight-
nine-
ten-
eleven-
twelve-
thirteen-
fourteen-)


REPLACEMENTS=(1-default-in-attribute-file-
2-default-in-recipe-
3-environment-default-
4-default-in-role-
5-force-default-in-attribute-file-
6-force-default-in-recipe-
7-normal-in-attribute-file-
8-normal-in-recipe-
9-override-in-attribute-file-
10-override-in-recipe-
11-override-in-role-
12-ovverride-in-environment-
13-force-override-in-attribute-file-
14-force-override-in-recipe-)

for i in `seq 1 14` ;  do
    subject=${SUBJECTS[$i-1]};
    replacement=${REPLACEMENTS[$i-1]};
    find . -name "*.rb" | xargs sed -i "s#${subject}#${replacement}#g"
done
