/**
 * 
 */
 
 function test2(result, filename, filekey){
	if(!isImg(filename)){
		result = "/resources/img/일반파일.png";
	}
	
	
	
   let str = `
<div class="col mb-4">
   <div class="card filename border-primary text-center ">
	<div>
      <img  src="${result}" alt="업로드한 파일의 썸네일" width="100px" height="100px">
    </div>
      <div class="card-body">
          <p class="card-text">${filename}</p>
          <a href="#" data-filekey="${filekey}" class="btn btn-danger btn_del_item" data-filename="new">삭제</a>
      </div>
   </div>
</div>
   `;
   
   return str;
} 
 

 
 
function test(result, filename){
	if(!isImg(filename)){
		result = "/resources/img/일반파일.png";
	}
	
	
	
   let str = `
<div class="col mb-4">
   <div class="card filename border-primary text-center ">
	<div>
      <img  src="${result}" alt="업로드한 파일의 썸네일" width="100px" height="100px">
    </div>
      <div class="card-body">
          <p class="card-text">${filename}</p>
      </div>
   </div>
</div>
   `;
   
   return str;
} 
 
 
   function showUploadItemTag(file){
	let filename= file["name"];
	
	  let imgSrc = '';
	  if (isImg(filename)) {
		  
		 imgSrc = "/displayfile?filename=" + filename;
		  

	  } else {
		  imgSrc = "/resources/img/일반파일.png";
	  }

	  let pText = filename;

	
	let str = `
	<div class="col mb-4">
		<div class="card filename border-primary text-center" style="width: 18rem;">
		 <img src="${imgSrc}" alt="업로드한 파일의 썸네일">
		  <div class="card-body">
		    <p class="card-text">${pText}</p>
		  </div>
		</div>
	</div>
	`;
	return str;
}
 
 
 
 function getAllUploadForUpdateUI(bno, uploadedItems){
	$.getJSON("/board/"+bno+"/uploadall", function(data){

		for(let i=0;i<data.length;i++){
			let filename = data[i];
			let str= makeUploadItemTag2(filename);
			uploadedItems.append(str);		
		}
		
	});
}
 
 
 
 
 function getAllUpload(bno, uploadedItems){
	/*json 형태로 가져온다  (객체)*/ 
	$.getJSON("/board/"+bno+"/uploadall", function(data){

		for(let i=0;i<data.length;i++){
			let filename = data[i];
			let str= makeUploadItemTagForRead(filename);
			uploadedItems.append(str);		
		}
		
	});
}
 
 
 
 
  function makeUploadItemTagForRead(filename){
	
	  let imgSrc = '';
	  if (isImg(filename)) {
		  imgSrc = "/displayfile?filename=" + filename;

	  } else {
		  imgSrc = "/resources/img/일반파일.png";
	  }

	  let aHref = '';
	  if (isImg(filename)) {
		  aHref = "/displayfile?filename=" + getImgFilePath(filename);
	  } else {
		  aHref = "/displayfile?filename=" + filename;
	  }


	  let pText = getOrgName(filename);

	  let btnDataFilename = filename;

	
	let str = `
	<div class="col mb-4">
		<div class="card filename border-primary text-center" style="width: 18rem;">
		  <a href="${aHref}" target="_blank"><img src="${imgSrc}" alt="업로드한 파일의 썸네일"></a>
		  <div class="card-body">
		    <p class="card-text">${pText}</p>
		  </div>
		</div>
	</div>
	`;
	return str;
}
 
 
  function makeUploadItemTag2(filename){
	
	  let imgSrc = '';
	  if (isImg(filename)) {
		  imgSrc = "/displayfile?filename=" + filename;

	  } else {
		  imgSrc = "/resources/img/일반파일.png";
	  }

	  let aHref = '';
	  if (isImg(filename)) {
		  aHref = "/displayfile?filename=" + getImgFilePath(filename);
	  } else {
		  aHref = "/displayfile?filename=" + filename;
	  }


	  let pText = getOrgName(filename);

	  let btnDataFilename = filename;

	
	let str = `
	<div class="col mb-4">
		<div class="card filename border-primary text-center" style="width: 18rem;">
		  <a href="${aHref}" target="_blank"><img src="${imgSrc}" alt="업로드한 파일의 썸네일"></a>
		  <div class="card-body">
		    <p class="card-text">${pText}</p>
		    <a href="#" class="btn btn-danger btn_del_item" data-filename="${btnDataFilename}">삭제</a>
		  </div>
		</div>
	</div>
	`;
	return str;
}
 
 
 
 function makeUploadItemTag(imgSrc, aHref, pText, btnDataFilename){
	let str = `
	<div class="col mb-4">
		<div class="card filename border-primary text-center" style="width: 18rem;">
		  <a href="${aHref}" target="_blank"><img src="${imgSrc}" alt="업로드한 파일의 썸네일"></a>
		  <div class="card-body">
		    <p class="card-text">${pText}</p>
		    <a href="#" class="btn btn-danger btn_del_item" data-filename="${btnDataFilename}">삭제</a>
		  </div>
		</div>
	</div>
	`;
	return str;
}
 
 
 
 		function getOrgName(filename) {
			
			let orgName ="";
			let idx= -1;
			
			if(isImg(filename)){
				idx = filename.indexOf("_", 14) + 1;
				
			}else{
				idx = filename.indexOf("_") + 1;
			}
			
			orgName = filename.substring(idx);
			
			return orgName;
			
			
		}
		
		
		
		function getImgFilePath(filename) {
			let prefix = filename.substring(0, 12);
			let suffix = filename.substring(14);
			return prefix + suffix;
			
			
		}
		
		
		function isImg(filename) {
			let idx = filename.lastIndexOf(".") + 1;
			let formatName = filename.substring(idx).toLowerCase();
			if(formatName == "png" || formatName == "gif" 
					|| formatName == "jpg" || formatName =="jpeg"){
				return true;
			}else{
				return false;
			}
		}
 
 
  function getAllReply2(bno, el){
	let tagStr="";
	
	$.getJSON("/replies/"+bno+"/all", function(result){
		for(let i =0;i<result.length;i++){
			let item = result[i];
			let str = makeItemTag(item);
			tagStr += str;	
		}
		
		el.html(tagStr);
	});  
}
 
 
 
 function getAllReply(bno, el){
	el.html("");
	
	$.getJSON("/replies/"+bno+"/all", function(result){
		for(let i =0;i<result.length;i++){
			let item = result[i];
			let str = makeItemTag(item);
			el.append(str);	
		}
	});  
}

function makeItemTag(item) {
	let str = `
	<div class="card item my-4">
  <div class="card-header">
    <span>댓글번호 : ${item.rno}</span> <span class="float-right">작성일 : ${item.updateDay}</span> 
  </div>
  <div class="card-body">
    <h5 class="card-title">${item.replyer}</h5>
    <p class="card-text">${item.replyText}</p>
    <a data-rno="${item.rno}" href="#" class="btn btn-primary item_btn_update">수정</a>
    <a data-rno="${item.rno}" href="#" class="btn btn-primary item_btn_delete">삭제</a>
  </div>
</div>
	`;

	return str;
}