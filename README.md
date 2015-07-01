# Alpha-Post-Builder

Converts raw information from social network (fb, twitter, vk, instagram) into common `post` and `user` format

## Installation

Add this line to your application's Gemfile:

    gem 'alpha_post_builder', git: 'git@github.com:snagency/alpha-post-builder.git', branch: 'master'

And then execute:

    $ bundle install

## Usage

Suppose you got some kind of hash response from any social network.

    result = TwitterClient.search('#snow').first

Then just pass it to `#filter` method any you would get resulting hash with `:user` and `:post` values coerced into common format

    AlphaPostBuilder.filter(:twitter, result)

Or you can use corresponding builder directly

    AlphaPostBuilder::TwitterBuilder.filter(result)

Currently there are following builders and its classes

|name         |class                                |
|-------------|-------------------------------------|
|`:direct_url` |`AlphaPostBuilder::DirectUrlBuilder` |
|`:facebook`   |`AlphaPostBuilder::FacebookBuilder`  |
|`:instagram`  |`AlphaPostBuilder::InstagramBuilder` |
|`:twitter`    |`AlphaPostBuilder::TwitterBuilder`   |
|`:vkontakte`  |`AlphaPostBuilder::VkontakteBuilder` |
|`:yandex`     |`AlphaPostBuilder::YandexBuilder`    |

## Sample output

```ruby
{
  title: nil,
  network: "twitter",
  location: "Wisconsin, USA",
  media_type: nil,
  image_url: nil,
  created_time: 1435711203,
  text: "The Foolish Mortals #freebandnames",
  post_id: "249279667666817024",
  url: nil,
  user: {
    location: "Wisconsin, USA",
    friends_count: 249,
    followers_count: 608,
    screen_name: "37539828",
    image: "http://a0.twimg.com/profile_images/1629790393/shrinker_2000_trans_normal.png",
    url: "http://www.omnitarian.me",
    uid: "Omnitarian",
    name: "Marty Elmer"
  }
}
````
## Local development

You can set bundler to work with local copy of gem

    bundle config local.alpha_post_builder /path/to/gem
