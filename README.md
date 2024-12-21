This repository provides a simple, automated solution to monitor rusk log events and send notifications using a Telegram bot

### 1. Use Cron to Schedule the Command 
Cron is a task scheduler in Linux that allows you to run commands at specified intervals. 
 
1. Edit your crontab:
   ```crontab -e```
2. Add a cron job (e.g., run every 30 minutes):\
   ```*/30 * * * * grep "execute_state_transition" /var/log/rusk.log | tail -n 5 > /tmp/rusk_output.log && /opt/bot/notify_script.sh```\
   If you're unfamiliar with vi editor (a common default editor), follow these steps:
   - Press ```i``` to enter insert mode (you can now paste or type your command).
   - Add your command at the end of the document
   - Press Esc to exit insert mode.
   - Type ```:wq``` and press Enter to save and exit.
   - If you make a mistake:\
     Press Esc and type ```:q!``` followed by Enter to exit without saving, then retry the process.

### 2. Set Up a Telegram Bot for Notifications 
Telegram bots are an easy way to send notifications. Follow these steps: 

1. Create a Telegram Bot: 
   - Open Telegram and search for BotFather. 
   - Send /start to BotFather. 
   - Send /newbot and follow the instructions to create a bot. 
   - Note down the API token BotFather gives you. 
 
2. Find Your Chat ID: 
   - Open a chat with your bot and send a message. 
   - Use this command to find your chat ID (replace `BOT_API_TOKEN`): \
     ```curl -s "https://api.telegram.org/bot<BOT_API_TOKEN>/getUpdates" | jq '.result[].message.chat.id'```

3. Copy and modify the contents of ```notify_script.sh``` from this repository into your VM:
   - Create a folder where the script will be located: ```mkdir /opt/bot```
   - Grant permissions to read and write files in the folder and its subdirectories: ```chmod -R a+rw /opt/bot```
   - Create the script file: ```vi /opt/bot/notify_script.sh```. (If you are unfamiliar with Vi, refer to the instructions in Step 1.)
   - Paste the script's contents into the file and update the variables with your values.
   - Save.
   - Make script executable: ```chmod +x /opt/bot/notify_script.sh ```

### 4. Test It 
Run the script manually to test: 
```
grep "execute_state_transition" /var/log/rusk.log | tail -n 5 > /tmp/rusk_output.log
```
```
bash /opt/bot/notify_script.sh
```
You should see the latest 5 log lines in your Telegram. 
