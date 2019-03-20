require_relative "test_helper"

describe SlackApi do
  describe "list users" do
    it "returns valid users" do
      VCR.use_cassette("slack_users_list") do
        users_list = SlackApi::User.user_api

        users_list.each do |user|
          expect(user["team_id"]).wont_be_nil
        end
      end
    end

    it "includes a specific user" do
      VCR.use_cassette("slack_user_list") do
        users_list = SlackApi::User.user_api

        expect(users_list.first["name"]).must_equal "slackbot"
      end
    end

    it "users list will only include existent users" do
      VCR.use_cassette("slack_users_list") do
        users_list = SlackApi::User.user_api

        users_list.each do |user|
          name = "Not a User"
          expect(user["name"]).wont_equal name
        end
      end
    end
    # it "returns info with a valid token" do
    #   VCR.use_cassette("slack_channels_list") do
    #     channels_list = SlackApi::Channel.channel_api

    #     expect(channels_list["ok"]).must_equal true
    #   end
    # end
  end
end

# users:

#tests -->

#0. make sure that what's being returned is in the format we want (i.e. a hash or array)

#1. make sure that what is returned are actual users
# expect(users.list) includes Amy

#2. make sure that the right things are being returned for each users
# expect { one component of Amy's user info is } real name
# expect { one component of Amy's user info is } slack_id
# expect { one component of Amy's user info is } username

#3. expect if there are NO users -> return empty array
