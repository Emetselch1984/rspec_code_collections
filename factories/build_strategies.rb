# Build strategies
# In factory_bot 5, associations default to using the same build strategy as their parent object:
# factory_bot 5では、アソシエーションはデフォルトで親オブジェクトと同じBuild strategiesを使用します。
FactoryBot.define do
  factory :author

  factory :post do
    author
  end
end

post = build(:post)
post.new_record?        # => true
post.author.new_record? # => true

post = create(:post)
post.new_record?        # => false
post.author.new_record? # => false

# これは、以前のバージョンの factory_bot のデフォルトの動作とは異なり、関連付けが常に親オブジェクトの戦略と一致するわけではありません。
# もし古い動作を使い続けたい場合は、 use_parent_strategy設定オプションをfalseに設定することができます。

FactoryBot.use_parent_strategy = false

# Builds and saves a User and a Post
post = create(:post)
post.new_record?        # => false
post.author.new_record? # => false

# Builds and saves a User, and then builds but does not save a Post
post = build(:post)
post.new_record?        # => true
post.author.new_record? # => false

# To not save the associated object, specify strategy: :build in the factory:
FactoryBot.use_parent_strategy = false

factory :post do
  # ...
  association :author, factory: :user, strategy: :build
end

# Builds a User, and then builds a Post, but does not save either
post = build(:post)
post.new_record?        # => true
post.author.new_record? # => true

