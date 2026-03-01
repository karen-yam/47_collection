# 都道府県データ
prefectures = [
  "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
  "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
  "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県",
  "岐阜県", "静岡県", "愛知県", "三重県",
  "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県",
  "鳥取県", "島根県", "岡山県", "広島県", "山口県",
  "徳島県", "香川県", "愛媛県", "高知県",
  "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"
]

# DB登録
prefectures.each do |name|
  Prefecture.find_or_create_by!(name: name)
end

# カテゴリー
categories = [
  "マグネット",
  "ポストカード",
  "グラス",
  "マグカップ",
  "Tシャツ",
  "帽子",
  "キーホルダー",
  "ステッカー",
  "食器",
  "ご当地キャラクターグッズ",
  "置物",
  "アクセサリー",
  "文房具",
  "タオル"
]

categories.each do |name|
  Category.find_or_create_by!(name: name)
end

# 開発環境seed
seed_file = Rails.root.join("db", "seeds", "#{Rails.env.downcase}.rb")
load seed_file if File.exist?(seed_file)
