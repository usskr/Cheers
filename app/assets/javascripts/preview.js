//投稿画像のプレビュー
$('#post_image').on('change', function (e) { //post_imageというidを持つ場所に変化があったらfunction(e)を実行
  var reader = new FileReader(); //readerを定義
  reader.onload = function (e) { //ファイルの読み込み
      $("#preview").attr('src', e.target.result); //idがpreviewになっているところに、画像データの取得結果を反映
  }
  reader.readAsDataURL(e.target.files[0]); //読み込まれた内容を実際に読み込む
});

//プロフィール画像のプレビュー
$('#user_profile_image').on('change', function (e) { //post_imageというidを持つ場所に変化があったらfunction(e)を実行
  var reader = new FileReader(); //readerを定義
  reader.onload = function (e) { //ファイルの読み込み
      $("#preview").attr('src', e.target.result); //idがpreviewになっているところに、画像データの取得結果を反映
  }
  reader.readAsDataURL(e.target.files[0]); //読み込まれた内容を実際に読み込む
});