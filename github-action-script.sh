echo 1. what is in a directory?
ls -a
echo
echo 2. Is java instaled?
java -version
echo
echo 3. Is git installed?
git --version
echo
echo 4. tools?
mvn --version
gradle --version
ant -version
echo
echo 5. Where is android SDK root?
echo $ANDROID_SDK_ROOT
echo
echo 7. Where is workspace location?
echo $RUNNER_WORKSPACE
echo
echo 8. Who is running this script?
whoami
echo 9. How is disc laid out?
df
echo 10. What environment variables are there?
env
