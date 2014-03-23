require 'metaproject'

project :blog do
  klass :post do
    attribute :title
    attribute :body
    attribute :tags
  end

  klass :comments do
    attribute :author
    attribute :created_at
    attribute :post_id
  end
end

post = Blog::Post.new "Hello", %w(hello first), <<EOF
  MetaProgramming
EOF

puts post.new.inspect