class Api::V1::PostsController < ApplicationController
    def index
       page = params[:page].to_i || 1 # ページ番号を取得し、整数に変換。もしページ番号が存在しない場合は1を使う
        per_page = 100 # 1ページあたりの表示数

        offset = (page - 1) * per_page # オフセット計算。表示する投稿データの開始位置を求める
        posts = Post.order(created_at: :desc).offset(offset).limit(per_page) # オフセットと表示数を使ってデータベースから投稿データを取得

        @post_data = [] # 空の配列を作成

        # 取得した投稿データを1件ずつ処理
        posts.each do |post|
            @post_data << { title: post.title, body: post.body } # タイトルと本文をハッシュとして作成し、配列に追加
        end

      render json: @post_data #@post_dataをJSON形式でレスポンスとして返す

    end
end
