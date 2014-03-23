require 'test_helper'
require 'metaproject/dsl'

module MetaProject
  describe DSL do
    let(:dsl) { DSL.new }

    it 'allows to create a project' do
      dsl.project :blog

      Blog.must_be_kind_of Module
    end

    it 'allows a class to be created inside the project' do
      dsl.project :blog do
        klass :post
      end

      Blog::Post.must_be_kind_of Class
    end

    it 'allows a class to have attribute' do
      dsl.project :blog do
        klass :post do
          attribute :title
          attribute :body
        end
      end

      post = Blog::Post.new "Title", "Body"
      post.title.must_equal "Title"
    end

    it 'allows a class to have attribute' do
      dsl.project :blog do
        klass :post do
          attribute :title
          attribute :body
        end

        klass :comment do
          attribute :author
          attribute :body
        end
      end

      comment = Blog::Comment.new "Andrii", "Some text"
      comment.body.must_equal "Some text"
    end
  end
end