let map //変数の定義
let geocoder //変数の定義
let marker = []; //マーカーを複数表示させたいので、配列化
let infoWindow = []; //吹き出しを複数表示させたいので、配列化
let markerData = null; //変数の初期値
if (typeof gon !== 'undefined' && gon != null) { //gonが定義されているかつ空でない
  markerData = gon.spots; //コントローラーで定義したインスタンス変数を変数に代入
}
let id = markerData //各スポットのIDを変数化

function initMap(){ //コールバック関数
  geocoder = new google.maps.Geocoder() //GoogleMapsAPIジオコーディングサービスにアクセス
  if(document.getElementById('map')){ //'map'というidを取得できたら実行
    map = new google.maps.Map(document.getElementById('map'), { //'map'というidを取得してマップを表示
      center: {lat: 35.6594666, lng: 139.7005536}, //最初に表示する場所（「渋谷スクランブル交差点」が初期値）
      zoom: 15, //拡大率（1〜21まで設定可能）
    });

  }else if(document.getElementById('show_map')){ //'show_map'というidを取得できたら実行
    map = new google.maps.Map(document.getElementById('show_map'), { //'show_map'というidを取得してマップを表示
      center: {lat: gon.lat, lng: gon.lng}, //controllerで定義した変数を緯度・経度の値とする（値はDBに入っている）
      zoom: 15, //拡大率（1〜21まで設定可能）
    });

    marker = new google.maps.Marker({ //GoogleMapにマーカーを落とす
      position:  {lat: gon.lat, lng: gon.lng}, //マーカーを落とす位置を決める（値はDBに入っている）
      map: map //マーカーを落とすマップを指定
    });

  }else{ //'map'、'show_map'というidが無かった場合
    map = new google.maps.Map(document.getElementById('all_map'), { //'all_map'というidを取得してマップを表示
      center: {lat: 35.6594666, lng: 139.7005536}, //最初に表示する場所（「渋谷スクランブル交差点」が初期値）
      zoom: 10, //拡大率（1〜21まで設定可能）
    });

      for (var i = 0; i < markerData.length; i++) { //繰り返し処理でマーカーと吹き出しを複数表示させる
        let id = markerData[i]['id']

        markerLatLng = new google.maps.LatLng({ //各地点の緯度経度を算出
          lat: markerData[i]['latitude'],
          lng: markerData[i]['longitude']
        });

        marker[i] = new google.maps.Marker({ //各地点のマーカーを作成
          position: markerLatLng,
          map: map
        });

        infoWindow[i] = new google.maps.InfoWindow({ //infoWindowは吹き出し
          content: `<a href='/spots/${ id }'>${ markerData[i]['address'] }</a>` //吹き出しの中身をリンクにする
        });

        markerEvent(i); //マーカーにクリックイベントを追加
      }
  }
}

function markerEvent(i) { //マーカーをクリックしたら吹き出しを表示
    marker[i].addListener('click', function () {
      infoWindow[i].open(map, marker[i]);
    });
  }

function codeAddress(){ //コールバック関数
  let inputAddress = document.getElementById('address').value; //'address'というidの値（value）を取得

  geocoder.geocode( { 'address': inputAddress}, function(results, status) { //ジオコードしたい住所を引数として渡す
    if (status == 'OK') {
      let lat = results[0].geometry.location.lat(); //ジオコードした結果の緯度
      let lng = results[0].geometry.location.lng(); //ジオコードした結果の経度
      let mark = {
          lat: lat, //緯度
          lng: lng  //経度
      };
      map.setCenter(results[0].geometry.location); //最も近い、判読可能な住所を取得したい場所の緯度・経度
      let marker = new google.maps.Marker({
          map: map, //マーカーを落とすマップを指定
          position: results[0].geometry.location //マーカーを落とす位置を決める
      });
    } else {
      alert('該当する結果がありませんでした');
    }
  });
}