# Configuration

1. Modify data/campaigns.yaml to reflect the campaigns that you would like to send
2. Set a list of enter-separated e-mail addresses in data/emails.csv

# Running

1. Open two terminal windows
2. In both, run `bundle`
3. In one window, run `bundle exec "rake resque:work QUEUE=marketing_email"`
4. In the other window, run `bundle exec rake run`
5. Monitor queue size via `resque-web` (optional)

# Dry Run

For a dry run, set the DRY_RUN=true environment variable:

`{"test_1"=>["jberlinsky@gmail.com", "jason4@gmail.com"], "test_3"=>["jason3@gmail.com", "jason2@gmail.com"], "test_2"=>["jason@facebook.com"]}
5 e-mails across 3 campaigns.
Bucket counts:
test_1: 2
test_3: 2`
