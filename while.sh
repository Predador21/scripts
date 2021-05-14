while true 
   do
   gcloud cloud-shell ssh --command='~/ping.sh' --authorize-session --account g0803211625@gmail.com
   sleep 60
done
