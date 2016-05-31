var mongoose = require('mongoose');
var musicDTO = require('../DTO/musicDTO');
var fs = require('fs');
module.exports = {};

module.exports.createMusic = function(req, res) {
	var newMusic = new musicDTO();
	newMusic._id = new mongoose.Types.ObjectId;
    newMusic.singerName = req.body.singerName;
	newMusic.musicName = req.body.musicName;
	newMusic.albumName = req.body.albumName;
	newMusic.lyrics = req.body.lyrics;
    newMusic.pathName = req.body.pathName;
    newMusic.save();
};

module.exports.readMusic = function(req, res) {
	musicDTO.find({ _id : req.body.id }, function (err, result) {
		if(err) return err;
		res.writeHead(200, {"Content-Type": "application/json"});
	    res.end(JSON.stringify(result));
	    console.log("[!] Music : " + result +"\n");
	});

};

module.exports.updateMusic = function(req, res) {
	musicDTO.findById(req.body.id, function (err, music) {
	  if (err) return handleError(err);
      music.singerName = req.body.singerName;
	  music.musicName = req.body.musicName;
	  music.albumName = req.body.albumName;
      music.lyrics = req.body.lyrics;
      music.pathName = req.body.pathName;
	  music.save(function (err) {
	    if (err) return handleError(err);
	    res.send(music);
	  });
	});
};

module.exports.deleteMusic = function(req, res) {
	musicDTO.remove({ _id : req.body.id }, function(err,removed) {
		if (err) return handleError(err);	
		res.writeHead(200, {"Content-Type": "application/json"});
	    res.end(JSON.stringify(result));
	});
};


module.exports.startMusic = function(req, res) {
	var basicPath = "/Volumes/Doc/workspace-vibe/VIBE/VIBE_Server/storage"
    var stream = fs.createReadStream("/Volumes/Doc/workspace-vibe/VIBE/VIBE_Server/storage/one.mp3");
    stream.pipe(res);
};

module.exports.outMusic = function(req,res) {
    console.log("[!] ID : ["+ req.params.id +"] FOR STREAM");
    var basicPath = "./storage"

    musicDTO.findOne({ _id : req.params.id }, { '_id': 0, '__v': 0}, function (err, result) {
        if(err) return err;
        //res.writeHead(200, {"Content-Type": "application/json"});
        //res.end(JSON.stringify(result));
        console.log("[!] " + result.pathName);
        
        fs.exists(basicPath+result.pathName, function (exists) {
          if(exists) {
            console.log("[=] exists");
            var stream = fs.createReadStream(basicPath+result.pathName);
            stream.pipe(res);
          } else {
            console.log("[=] not exists");

          }
        });
    });

}





/*
module.exports.temp1 = function(req, res) {
	
    console.log("[!] Start1\n");
    //1
	var basicPath = "/Volumes/Doc/workspace-vibe/VIBE/VIBE_Server/storage"
	var newMusic = new musicDTO();
    newMusic.singerName = "김동률";
	newMusic.musicName = "오래된노래";
	newMusic.albumName = "Monologue";
	newMusic.lyrics = "우연히 찾아낸 낡은 테입속의 노랠 들었어 서투른 피아노 풋풋한 목소리 수많은 추억에 웃음 짓다 언젠가 너에게 생일 선물로 만들어준 노래 촌스런 반주에 가사도 없지만 넌 아이처럼 기뻐했었지";
    newMusic.pathName = "/1/김동률-오래된 노래.mp3";
    newMusic.save();
    //2
    newMusic = new musicDTO();
    newMusic.singerName = "로코베리";
	newMusic.musicName = "I.O.U";
	newMusic.albumName = "I.O.U";
	newMusic.lyrics = "오래 두었지 내방 창가엔 ";
    newMusic.pathName = "/1/로코베리-I.O.U.mp3";
    newMusic.save();
	//3
    newMusic = new musicDTO();
    newMusic.singerName = "메이트";
	newMusic.musicName = "하루";
	newMusic.albumName = "END OF THE WORLD";
	newMusic.lyrics = "이젠 모두 끝인거라 생각했어";
    newMusic.pathName = "/1/메이트-하루.mp3";
    newMusic.save();
    //4
    newMusic = new musicDTO();
    newMusic.singerName = "박새별";
	newMusic.musicName = "사랑이 우릴 다시 만나게 한다면";
	newMusic.albumName = "하이힐";
	newMusic.lyrics = "사랑이 우릴 다시 만나게 한다면";
    newMusic.pathName = "/1/박새별-사랑이 우릴 다시 만나게 한다면.mp3";
    newMusic.save();
    //5
	newMusic = new musicDTO();
    newMusic.singerName = "스웨덴세탁소";
	newMusic.musicName = "목소리(Feat.정기고)";
	newMusic.albumName = "목소리";
	newMusic.lyrics = "목소리만 들어도 ";
    newMusic.pathName = "/1/스웨덴세탁소-목소리(Feat.정기고).mp3";
    newMusic.save();
    //6
	newMusic = new musicDTO();
    newMusic.singerName = "어반자카파";
	newMusic.musicName = "코끝에 겨울";
	newMusic.albumName = "[03]";
	newMusic.lyrics = "점차 나아지겠지 혼자 내렸던 ";
    newMusic.pathName = "/Volumes/Doc/workspace-vibe/VIBE/VIBE_Server/storage/1/어반자카파-코끝에 겨울.mp3";
    newMusic.save();
    //7
    newMusic = new musicDTO();
    newMusic.singerName = "유재하";
	newMusic.musicName = "그대 내 품에";
	newMusic.albumName = "사랑하기 때문에";
	newMusic.lyrics = "별 헤는 밤이면";
    newMusic.pathName = "/1/유재하-그대 내 품에.mp3";
    newMusic.save();
	//8
	newMusic = new musicDTO();
    newMusic.singerName = "유재하";
	newMusic.musicName = "사랑하기 때문에";
	newMusic.albumName = "사랑하기 때문에";
	newMusic.lyrics = "처음 느낀 그대 눈빛은";
    newMusic.pathName = "/1/유재하-사랑하기 때문에.mp3";
    newMusic.save();
	//9
	newMusic = new musicDTO();
    newMusic.singerName = "태양";
	newMusic.musicName = "눈,코,입";
	newMusic.albumName = "RISE";
	newMusic.lyrics = "미안해 미안해 하지마";
    newMusic.pathName = "/1/태양-눈,코,입.mp3";
    newMusic.save();
	//10
	newMusic = new musicDTO();
    newMusic.singerName = "40";
	newMusic.musicName = "듣는편지";
	newMusic.albumName = "듣는편지";
	newMusic.lyrics = "저 별을 가져다";
    newMusic.pathName = "/1/40-듣는편지.mp3";
    newMusic.save();
    console.log("[!] Complete1\n");
};

module.exports.temp2 = function(req, res) {
	
    console.log("[!] Start2\n");
    //1
	var basicPath = "/Volumes/Doc/workspace-vibe/VIBE/VIBE_Server/storage"
	var newMusic = new musicDTO();
    newMusic.singerName = "빈지노";
	newMusic.musicName = "Break";
	newMusic.albumName = "Break";
	newMusic.lyrics = "난 자유롭고 싶어";
    newMusic.pathName = "/2/빈지노-Break.mp3";
    newMusic.save();
    //2
    newMusic = new musicDTO();
    newMusic.singerName = "빈지노";
	newMusic.musicName = "Life In Color (prod. PEEJAY)";
	newMusic.albumName = "Life In Color";
	newMusic.lyrics = "색깔 없는 과일 누가 먹겠니 ";
    newMusic.pathName = "/2/빈지노-Life In Color (prod. PEEJAY).mp3";
    newMusic.save();
	//3
    newMusic = new musicDTO();
    newMusic.singerName = "윤종신";
	newMusic.musicName = "The Color (with Beenzino)";
	newMusic.albumName = "2015 월간 윤종신 4월호";
	newMusic.lyrics = "어제도 만족 그제도 만족 ";
    newMusic.pathName = "/2/윤종신-The Color (with Beenzino).mp3";
    newMusic.save();
    //4
    newMusic = new musicDTO();
    newMusic.singerName = "지코";
	newMusic.musicName = "Boys And Girls (Feat. Babylon)";
	newMusic.albumName = "Boys And Girls";
	newMusic.lyrics = "Don't worry about money";
    newMusic.pathName = "/1/지코-Boys And Girls (Feat. Babylon).mp3";
    newMusic.save();
    //5
	newMusic = new musicDTO();
    newMusic.singerName = "태양";
	newMusic.musicName = "새벽한시(1AM)";
	newMusic.albumName = "RISE";
	newMusic.lyrics = "하나 둘씩 잊어가";
    newMusic.pathName = "/2/태양-새벽한시(1AM).mp3";
    newMusic.save();
    //6
	newMusic = new musicDTO();
    newMusic.singerName = "태양";
	newMusic.musicName = "Stay with me (Feat G-Dragon)";
	newMusic.albumName = "RISE";
	newMusic.lyrics = "그대도 나와 같은 ";
    newMusic.pathName = "/2/태양-Stay with me (Feat G-Dragon).mp3";
    newMusic.save();
    //7
    newMusic = new musicDTO();
    newMusic.singerName = "Coldplay";
	newMusic.musicName = "Paradise";
	newMusic.albumName = "Paradise";
	newMusic.lyrics = "When she was just a girl ";
    newMusic.pathName = "/2/Coldplay-Paradise.mp3";
    newMusic.save();
	//8
	newMusic = new musicDTO();
    newMusic.singerName = "G-DRAGON";
	newMusic.musicName = "CRAYON(크레용)";
	newMusic.albumName = "One Of A Kind";
	newMusic.lyrics = "GET YOUR CRAYON";
    newMusic.pathName = "/2/G-DRAGON-CRAYON(크레용).mp3";
    newMusic.save();
	//9
	newMusic = new musicDTO();
    newMusic.singerName = "G-DRAGON";
	newMusic.musicName = "삐딱하게(CROOKED)";
	newMusic.albumName = "쿠데타 (COUP D`ETAT)";
	newMusic.lyrics = "영원한 건 절대 없어";
    newMusic.pathName = "/2/G-DRAGON-삐딱하게(CROOKED).mp3";
    newMusic.save();
	//10
	newMusic = new musicDTO();
    newMusic.singerName = "Gray";
	newMusic.musicName = "하기나 해 (Feat. Loco)";
	newMusic.albumName = "grayground. 01";
	newMusic.lyrics = "영원하길 바래";
    newMusic.pathName = "/2/Gray-하기나 해 (Feat. Loco).mp3";
    newMusic.save();
    //11
	newMusic = new musicDTO();
    newMusic.singerName = "Simon Dominic";
	newMusic.musicName = "Simon Dominic(사이먼 도미닉)";
	newMusic.albumName = "￦ & ONLY";
	newMusic.lyrics = "Simon Simon Dominic";
    newMusic.pathName = "/2/Simon Dominic-Simon Dominic(사이먼 도미닉).mp3";
    newMusic.save();
    //12
	newMusic = new musicDTO();
    newMusic.singerName = "Trey Songz";
	newMusic.musicName = "Slow Motion";
	newMusic.albumName = "Trigga Reloaded";
	newMusic.lyrics = "I know you got all dressed up for the club";
    newMusic.pathName = "/2/Trey Songz-Slow Motion.mp3";
    newMusic.save();
    console.log("[!] Complete2\n");
};


module.exports.temp3 = function(req, res) {
	
    console.log("[!] Start3\n");
    //1
	var basicPath = "/Volumes/Doc/workspace-vibe/VIBE/VIBE_Server/storage"
	var newMusic = new musicDTO();
    newMusic.singerName = "다이나믹 듀오";
	newMusic.musicName = "BAAAM (feat. Muzie of UV)";
	newMusic.albumName = "Luckynumbers";
	newMusic.lyrics = "오전에 보낸 문자는 메아리가 없어 ";
    newMusic.pathName = "/3/다이나믹 듀오-BAAAM (feat. Muzie of UV).mp3";
    newMusic.save();
    //2
    newMusic = new musicDTO();
    newMusic.singerName = "박재범";
	newMusic.musicName = "원해 (WANT IT) (Feat. 천재노창 & 비프리)";
	newMusic.albumName = "WORLDWIDE";
	newMusic.lyrics = "무척 많은 돈을 내가 원해 ";
    newMusic.pathName = "/3/박재범-원해 (WANT IT) (Feat. 천재노창 & 비프리).mp3";
    newMusic.save();
    //3
    newMusic = new musicDTO();
    newMusic.singerName = "슈프림팀";
	newMusic.musicName = "땡땡땡";
	newMusic.albumName = "Spin Off (Repackage)";
	newMusic.lyrics = "Throw your elbows up ";
    newMusic.pathName = "/3/슈프림팀-땡땡땡.mp3";
    newMusic.save();
    //4
    newMusic = new musicDTO();
    newMusic.singerName = "스윙스";
	newMusic.musicName = "Bulldozer(불도저)";
	newMusic.albumName = "Double Single (Bulldozer)";
	newMusic.lyrics = "잠깐 쉬는 시간 좀 가졌지";
    newMusic.pathName = "/3/스윙스-Bulldozer(불도저).mp3";
    newMusic.save();
    //5
    newMusic = new musicDTO();
    newMusic.singerName = "씨잼";
	newMusic.musicName = "Good Day (Feat. Swings)";
	newMusic.albumName = "쇼미더머니3 Part.4";
	newMusic.lyrics = "Today is a good day ";
    newMusic.pathName = "/3/씨잼-Good Day (Feat. Swings).mp3";
    newMusic.save();
    //6
    newMusic = new musicDTO();
    newMusic.singerName = "천재노창";
	newMusic.musicName = "All Day (feat. 타블로)";
	newMusic.albumName = "All Day (feat. 타블로)";
	newMusic.lyrics = "난 항상 너가 그리워";
    newMusic.pathName = "/3/천재노창-All Day (feat. 타블로).mp3";
    newMusic.save();
    //7
    newMusic = new musicDTO();
    newMusic.singerName = "Eminem";
	newMusic.musicName = "Forever feat Kanye West, Lil Wayne and Drake";
	newMusic.albumName = "Relapse: Refill";
	newMusic.lyrics = "It may not mean nothing to yall";
    newMusic.pathName = "/3/Eminem-Forever feat Kanye West, Lil Wayne and Drake.mp3";
    newMusic.save();
	//8
    newMusic = new musicDTO();
    newMusic.singerName = "Mark Ronson";
	newMusic.musicName = "Uptown Funk ft. Bruno Mars";
	newMusic.albumName = "Uptown Funk ft. Bruno Mars";
	newMusic.lyrics = "This hit";
    newMusic.pathName = "/3/Mark Ronson-Uptown Funk ft. Bruno Mars.mp3";
    newMusic.save();
    //9
    newMusic = new musicDTO();
    newMusic.singerName = "Various Artists";
	newMusic.musicName = "YGGR (연결고리) SMTM Remix";
	newMusic.albumName = "연결고리 Remixes";
	newMusic.lyrics = "show me the money come ";
    newMusic.pathName = "/3/Various Artists-YGGR (연결고리) SMTM Remix.mp3";
    newMusic.save();

    console.log("[!] Complete3\n");
};

module.exports.temp4 = function(req, res) {
    
    console.log("[!] Start4\n");
    //1
    var basicPath = "/Volumes/Doc/workspace-vibe/VIBE/VIBE_Server/storage"
    var newMusic = new musicDTO();
    newMusic.singerName = "김광석";
    newMusic.musicName = "서른즈음에";
    newMusic.albumName = "서른즈음에";
    newMusic.lyrics = "";
    newMusic.pathName = "/4/김광석-서른즈음에.mp3";
    newMusic.save();
    //2
    newMusic = new musicDTO();
    newMusic.singerName = "바이브";
    newMusic.musicName = "바래다주는길";
    newMusic.albumName = "Re-fill";
    newMusic.lyrics = "";
    newMusic.pathName = "/4/바이브-바래다주는길.mp3";
    newMusic.save();
    //3
    newMusic = new musicDTO();
    newMusic.singerName = "버즈";
    newMusic.musicName = "Monologue";
    newMusic.albumName = "";
    newMusic.lyrics = "";
    newMusic.pathName = "/4/버즈-Monologue.mp3";
    newMusic.save();
    //4
    newMusic = new musicDTO();
    newMusic.singerName = "싸이";
    newMusic.musicName = "아버지";
    newMusic.albumName = "아버지";
    newMusic.lyrics = "";
    newMusic.pathName = "/4/싸이-아버지.mp3";
    newMusic.save();
    //5
    newMusic = new musicDTO();
    newMusic.singerName = "이문세";
    newMusic.musicName = "그녀의 웃음소리뿐";
    newMusic.albumName = "독창회";
    newMusic.lyrics = "";
    newMusic.pathName = "/4/이문세-그녀의 웃음소리뿐.mp3";
    newMusic.save();
    //6
    newMusic = new musicDTO();
    newMusic.singerName = "이문세";
    newMusic.musicName = "옛사랑";
    newMusic.albumName = "이문세 Best";
    newMusic.lyrics = "";
    newMusic.pathName = "/4/이문세-옛사랑.mp3";
    newMusic.save();
    //7
    newMusic = new musicDTO();
    newMusic.singerName = "이승환";
    newMusic.musicName = "어떻게사랑이그래요";
    newMusic.albumName = "Hwantastic";
    newMusic.lyrics = "";
    newMusic.pathName = "/4/이승환-어떻게사랑이그래요.mp3";
    newMusic.save();
    //8
    newMusic = new musicDTO();
    newMusic.singerName = "이적";
    newMusic.musicName = "걱정말아요 그대";
    newMusic.albumName = "응답하라 1988 OST part.2";
    newMusic.lyrics = "";
    newMusic.pathName = "/4/이적-걱정말아요 그대.mp3";
    newMusic.save();
    //9
    newMusic = new musicDTO();
    newMusic.singerName = "이승철";
    newMusic.musicName = "일기장";
    newMusic.albumName = "일기장";
    newMusic.lyrics = "";
    newMusic.pathName = "/4/이승철-일기장";
    newMusic.save();
    console.log("[!] Complete4\n");
};

module.exports.temp5 = function(req, res) {
	
    console.log("[!] Start5\n");
    //1
	var basicPath = "/Volumes/Doc/workspace-vibe/VIBE/VIBE_Server/storage"
	var newMusic = new musicDTO();
    newMusic.singerName = "Coldplay";
	newMusic.musicName = "Up&Up";
	newMusic.albumName = "Up&Up";
	newMusic.lyrics = "Fixing up a car to drive in it again";
    newMusic.pathName = "/5/Coldplay-Up&Up.mp3";
    newMusic.save();
    //2
    newMusic = new musicDTO();
    newMusic.singerName = "Dean";
    newMusic.musicName = "D (half moon)";
    newMusic.albumName = "130 mood : TRBL";
    newMusic.lyrics = "Love love the stars";
    newMusic.pathName = "/5/Dean-D (half moon).mp3";
    newMusic.save();
    //3
    newMusic = new musicDTO();
    newMusic.singerName = "Drake";
    newMusic.musicName = "Hold On, We’re Going Home ft. Majid Jordan";
    newMusic.albumName = "Nothing Was The Same (Deluxe Edition)";
    newMusic.lyrics = "I got my eyes on you";
    newMusic.pathName = "/5/Drake-Hold On, We’re Going Home ft. Majid Jordan.mp3";
    newMusic.save();
    //4
    newMusic = new musicDTO();
    newMusic.singerName = "Owen Ovadoz";
    newMusic.musicName = "City";
    newMusic.albumName = "City";
    newMusic.lyrics = "I've been riding";
    newMusic.pathName = "/5/Owen Ovadoz-City.mp3";
    newMusic.save();
    //5
    newMusic = new musicDTO();
    newMusic.singerName = "The Quiett";
    newMusic.musicName = "Be About It (Feat. Babylon)";
    newMusic.albumName = "1 Life 2 Live";
    newMusic.lyrics = "got so much money to get baby";
    newMusic.pathName = "/5/The Quiett-Be About It (Feat. Babylon).mp3";
    newMusic.save();
    //6
    newMusic = new musicDTO();
    newMusic.singerName = "천재노창";
    newMusic.musicName = "행";
    newMusic.albumName = "MY NEW INSTAGRAM : MESURECHIFFON";
    newMusic.lyrics = "내 단 한달 간의 ";
    newMusic.pathName = "/5/천재노창-행.mp3";
    newMusic.save();

    console.log("[!] Complete5\n");
};


module.exports.temp6 = function(req, res) {
    
    console.log("[!] Start6\n");
    //1
    var basicPath = "/Volumes/Doc/workspace-vibe/VIBE/VIBE_Server/storage"
    var newMusic = new musicDTO();
    newMusic.singerName = "Hans Zimmer";
    newMusic.musicName = "First Step";
    newMusic.albumName = "Interstella OST";
    newMusic.lyrics = "";
    newMusic.pathName = "/6/Hans Zimmer-First Step.mp3";
    newMusic.save();
    //2
    newMusic = new musicDTO();
    newMusic.singerName = "Hans Zimmer";
    newMusic.musicName = "Time";
    newMusic.albumName = "Badman and Superman";
    newMusic.lyrics = "--";
    newMusic.pathName = "/6/Hans Zimmer-Time.mp3";
    newMusic.save();
    //3
    newMusic = new musicDTO();
    newMusic.singerName = "Lady Antebellum";
    newMusic.musicName = "Need You Now";
    newMusic.albumName = "Need You Now";
    newMusic.lyrics = "picture perpect memories";
    newMusic.pathName = "/6/Lady Antebellum-Need You Now.mp3";
    newMusic.save();
    //4
    newMusic = new musicDTO();
    newMusic.singerName = "이하이";
    newMusic.musicName = "한숨";
    newMusic.albumName = "SEOULITE";
    newMusic.lyrics = "숨을 크게 쉬어봐요 ";
    newMusic.pathName = "/6/이하이-한숨.mp3";
    newMusic.save();
    //5
    newMusic = new musicDTO();
    newMusic.singerName = "로꼬";
    newMusic.musicName = "너도 (Feat. Cha Cha Malone)";
    newMusic.albumName = "너도";
    newMusic.lyrics = "누구나 떨리지 처음엔";
    newMusic.pathName = "/6/로꼬-너도 (Feat. Cha Cha Malone).mp3";
    newMusic.save();
    //6
    newMusic = new musicDTO();
    newMusic.singerName = "알리";
    newMusic.musicName = "365일";
    newMusic.albumName = "SOUL-RI : 영혼이 있는 마을";
    newMusic.lyrics = "우리 이별을 말 한지 ";
    newMusic.pathName = "/6/알리-365일.mp3";
    newMusic.save();
    //7
    newMusic = new musicDTO();
    newMusic.singerName = "크루셜 스타";
    newMusic.musicName = "그 벤치(The Bench)";
    newMusic.albumName = "그 벤치(The Bench)";
    newMusic.lyrics = "그 벤치에 앉아";
    newMusic.pathName = "/6/크루셜 스타-그 벤치(The Bench).mp3";
    newMusic.save();

    console.log("[!] Complete6\n");
};

module.exports.temp7 = function(req, res) {
    
    console.log("[!] Start7\n");
    //1
    var basicPath = "/Volumes/Doc/workspace-vibe/VIBE/VIBE_Server/storage"
    var newMusic = new musicDTO();
    newMusic.singerName = "Jessica";
    newMusic.musicName = "Fly (Feat. Fabolous)";
    newMusic.albumName = "Fly";
    newMusic.lyrics = "Invisible 안갯 속에 ";
    newMusic.pathName = "/7/Jessica-Fly (Feat. Fabolous).mp3";
    newMusic.save();
    //2
    newMusic = new musicDTO();
    newMusic.singerName = "Kendrick Lamar";
    newMusic.musicName = "i";
    newMusic.albumName = "i";
    newMusic.lyrics = "I done been through a whole lot ";
    newMusic.pathName = "/7/Kendrick Lamar-i.mp3";
    newMusic.save();
    //3
    newMusic = new musicDTO();
    newMusic.singerName = "PSY";
    newMusic.musicName = "DADDY(feat. CL of 2NE1)";
    newMusic.albumName = "DADDY";
    newMusic.lyrics = "I got it from my DADDY";
    newMusic.pathName = "/7/PSY-DADDY(feat. CL of 2NE1).mp3";
    newMusic.save();
    //4
    newMusic = new musicDTO();
    newMusic.singerName = "PSY";
    newMusic.musicName = "나팔바지";
    newMusic.albumName = "DADDY";
    newMusic.lyrics = "분위기 살려 어머 사람 살려";
    newMusic.pathName = "/7/PSY-나팔바지.mp3";
    newMusic.save();
    //5
    newMusic = new musicDTO();
    newMusic.singerName = "Taylor Swift";
    newMusic.musicName = "22";
    newMusic.albumName = "22";
    newMusic.lyrics = "It's";
    newMusic.pathName = "/7/Taylor Swift-22.mp3";
    newMusic.save();
    //6
    newMusic = new musicDTO();
    newMusic.singerName = "Taylor Swift";
    newMusic.musicName = "Bad Blood ft. Kendrick Lamar";
    newMusic.albumName = "Bad Blood";
    newMusic.lyrics = "'Cause baby now we got bad blood";
    newMusic.pathName = "/7/Taylor Swift-Bad Blood ft. Kendrick Lamar.mp3";
    newMusic.save();
    //7
    newMusic = new musicDTO();
    newMusic.singerName = "TWICE";
    newMusic.musicName = "CHEER UP";
    newMusic.albumName = "CHEER UP";
    newMusic.lyrics = "매일 울리는 벨벨벨";
    newMusic.pathName = "/7/TWICE-CHEER UP.mp3";
    newMusic.save();
    //8
    newMusic = new musicDTO();
    newMusic.singerName = "러블리즈";
    newMusic.musicName = "Ah-Choo";
    newMusic.albumName = "Ah-Choo";
    newMusic.lyrics = "맛있는 걸 해주고 싶은";
    newMusic.pathName = "/7/러블리즈-Ah-Choo.mp3";
    newMusic.save();
    //9
    newMusic = new musicDTO();
    newMusic.singerName = "박재범";
    newMusic.musicName = "NaNa";
    newMusic.albumName = "NaNa";
    newMusic.lyrics = "기분 다운 될 수 없어 주말이니까 ";
    newMusic.pathName = "/7/박재범-NaNa.mp3";
    newMusic.save();
    console.log("[!] Complete7\n");
};

module.exports.temp8 = function(req, res) {
    
    console.log("[!] Start8\n");
    //1
    var basicPath = "/Volumes/Doc/workspace-vibe/VIBE/VIBE_Server/storage"
    var newMusic = new musicDTO();
    newMusic.singerName = "Bryson Tiller";
    newMusic.musicName = "Don't";
    newMusic.albumName = "T R A P S O U L";
    newMusic.lyrics = "Don't, don't play with her don't be dishonest";
    newMusic.pathName = "/8/Bryson Tiller-Don't.mp3";
    newMusic.save();
    //2
    newMusic = new musicDTO();
    newMusic.singerName = "Bryson Tiller";
    newMusic.musicName = "Sorry Not Sorry";
    newMusic.albumName = "T R A P S O U L";
    newMusic.lyrics = "God damn I'm winning";
    newMusic.pathName = "/8/Bryson Tiller-Sorry Not Sorry.mp3";
    newMusic.save();
    //3
    newMusic = new musicDTO();
    newMusic.singerName = "Crush, 로꼬";
    newMusic.musicName = "아마도 그건";
    newMusic.albumName = "투유 프로젝트 - 슈가맨 Part.3";
    newMusic.lyrics = "아마도 그건 사랑이었을 거야";
    newMusic.pathName = "/8/Crush, 로꼬-아마도 그건.mp3";
    newMusic.save();
    //4
    newMusic = new musicDTO();
    newMusic.singerName = "Drake";
    newMusic.musicName = "One Dance feat. Wizkid & Kyla";
    newMusic.albumName = "Views";
    newMusic.lyrics = "Baby I like your style";
    newMusic.pathName = "/8/Drake-One Dance feat. Wizkid & Kyla.mp3";
    newMusic.save();
    //5
    newMusic = new musicDTO();
    newMusic.singerName = "Crush";
    newMusic.musicName = "Don’t Forget(Feat. 태연)";
    newMusic.albumName = "잊어버리지마";
    newMusic.lyrics = "너와 나 언젠가";
    newMusic.pathName = "/8/Crush-Don’t Forget(Feat. 태연).mp3";
    newMusic.save();
    //6
    newMusic = new musicDTO();
    newMusic.singerName = "Dr. Dre";
    newMusic.musicName = "I Need A Doctor ft. Eminem, Skylar Grey";
    newMusic.albumName = "I Need A Doctor";
    newMusic.lyrics = "I'm about to lose my mind";
    newMusic.pathName = "/8/Dr. Dre-I Need A Doctor ft. Eminem, Skylar Grey.mp3";
    newMusic.save();
    //7
    newMusic = new musicDTO();
    newMusic.singerName = "Suran";
    newMusic.musicName = "Calling in Love (Feat. Beenzino)";
    newMusic.albumName = "Calling in Love";
    newMusic.lyrics = "가고 있어";
    newMusic.pathName = "/8/Suran-Calling in Love (Feat. Beenzino).mp3";
    newMusic.save();
    //8
    newMusic = new musicDTO();
    newMusic.singerName = "이소라";
    newMusic.musicName = "바람이 분다";
    newMusic.albumName = "바람이 분다";
    newMusic.lyrics = "바람이 분다";
    newMusic.pathName = "/8/이소라-바람이 분다.mp3";
    newMusic.save();
    console.log("[!] Complete8\n");
    
};
module.exports.temp9 = function(req, res) {
    
    console.log("[!] Start9\n");
    //1
    var basicPath = "/Volumes/Doc/workspace-vibe/VIBE/VIBE_Server/storage"
    var newMusic = new musicDTO();
    newMusic.singerName = "10cm";
    newMusic.musicName = "스토커";
    newMusic.albumName = "스토커";
    newMusic.lyrics = "나도 알아";
    newMusic.pathName = "/9/10cm-스토커.mp3";
    newMusic.save();
    //2
    newMusic = new musicDTO();
    newMusic.singerName = "98Degrees";
    newMusic.musicName = "My Everything";
    newMusic.albumName = "Revelation";
    newMusic.lyrics = "The loneliness of nights so long ";
    newMusic.pathName = "/9/98Degrees-My Everything.mp3";
    newMusic.save();
    //3
    newMusic = new musicDTO();
    newMusic.singerName = "Babylon";
    newMusic.musicName = "비 오는 거리(Feat. 핫펠트)";
    newMusic.albumName = "BETWEEN US";
    newMusic.lyrics = "널 첨 봤을 때부터 난 ";
    newMusic.pathName = "/9/Babylon-비 오는 거리(Feat. 핫펠트).mp3";
    newMusic.save();
    //4
    newMusic = new musicDTO();
    newMusic.singerName = "Brian Mcknight";
    newMusic.musicName = "Back at One";
    newMusic.albumName = "Back at One";
    newMusic.lyrics = "it's undeiable";
    newMusic.pathName = "/9/Brian Mcknight-Back at One.mp3";
    newMusic.save();
    
    //5
    newMusic = new musicDTO();
    newMusic.singerName = "Brian Mcknight";
    newMusic.musicName = "One Last Cry";
    newMusic.albumName = "Greatest Hits";
    newMusic.lyrics = "";
    newMusic.pathName = "/9/Brian Mcknight-One Last Cry.mp3";
    newMusic.save();
    
    //6
    newMusic = new musicDTO();
    newMusic.singerName = "Eric Benet";
    newMusic.musicName = "Still With You";
    newMusic.albumName = "Hurricane";
    newMusic.lyrics = "Heaven knows what you've been through ";
    newMusic.pathName = "/9/Eric Benet-Still With You.mp3";
    newMusic.save();
    //7
    newMusic = new musicDTO();
    newMusic.singerName = "Frankie J";
    newMusic.musicName = "Don't Wanna Try";
    newMusic.albumName = "The One";
    newMusic.lyrics = "i can't believe u had the";
    newMusic.pathName = "/9/Frankie J-Don't Wanna Try.mp3";
    newMusic.save();
    //8
    newMusic = new musicDTO();
    newMusic.singerName = "Heize";
    newMusic.musicName = "돌아오지마 (Feat. 용준형 Of BEAST)";
    newMusic.albumName = "돌아오지마";
    newMusic.lyrics = "아직도 비가 내리면";
    newMusic.pathName = "/9/Heize-돌아오지마 (Feat. 용준형 Of BEAST).mp3";
    newMusic.save();
    //9
    newMusic = new musicDTO();
    newMusic.singerName = "Rachael Yamagata";
    newMusic.musicName = "Be Be Your Love";
    newMusic.albumName = "The Very Best Of Rachael Yamagata";
    newMusic.lyrics = "If I could take you away";
    newMusic.pathName = "/9/Rachael Yamagata-Be Be Your Love.mp3";
    newMusic.save();
    //10
    newMusic = new musicDTO();
    newMusic.singerName = "Sam Smith";
    newMusic.musicName = "I'm Not The Only One";
    newMusic.albumName = "In The Lonely Hour (Standard Edition)";
    newMusic.lyrics = "You and me we made a vow";
    newMusic.pathName = "/9/Sam Smith-I'm Not The Only One.mp3";
    newMusic.save();
    //11
    newMusic = new musicDTO();
    newMusic.singerName = "김범수";
    newMusic.musicName = "그댄 행복에 살텐데";
    newMusic.albumName = "투유 프로젝트 - 슈가맨 Part.16";
    newMusic.lyrics = "혼자인 시간이 싫어 s";
    newMusic.pathName = "/9/김범수-그댄 행복에 살텐데.mp3";
    newMusic.save();
    console.log("[!] Complete9\n");
};
*/

