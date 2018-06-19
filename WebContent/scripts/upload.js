/* Licence:
*   Use this however/wherever you like, just don't blame me if it breaks anything.
*
* Credit:
*   If you're nice, you'll leave this bit:
*
*   Class by Pierre-Alexandre Losson -- http://www.telio.be/blog
*   email : plosson@users.sourceforge.net
*/
function refreshProgress()
{
    UploadMonitor.getUploadInfo(updateProgress);
}

function updateProgress(uploadInfo)
{
    if (uploadInfo.inProgress)
    {
        var fileIndex = uploadInfo.fileIndex;

        var progressPercent = Math.ceil((uploadInfo.bytesRead / uploadInfo.totalSize) * 100);

        document.getElementById('progressBarText').innerHTML = 'upload em progresso: ' + progressPercent + '%';

        document.getElementById('progressBarBoxContent').style.width = parseInt(progressPercent * 3.0) + 'px';

        window.setTimeout('refreshProgress()', 1000);
    }

    return true;
}

function startProgress()
{
    document.getElementById('campoArquivo').style.display = 'none';
	document.getElementById('progressBar').style.display = 'block';
    document.getElementById('progressBarText').innerHTML = 'upload em progresso: 0%';

    // wait a little while to make sure the upload has started ..
    window.setTimeout("refreshProgress()", 1500);
    return true;
}

function limpaProgress()
{
	document.getElementById('campoArquivo').style.display = "";
	document.getElementById('progressBar').style.display = "none";
	document.getElementById('progressBarText').innerHTML = "";
	document.getElementById('progressBarBoxContent').style.width = "";
}


function refreshProgress2()
{
	
     UploadMonitor.getUploadInfo(updateProgress2);
}

function updateProgress2(uploadInfo)
{
   
	if (uploadInfo.inProgress)
    {
        var fileIndex = uploadInfo.fileIndex;

        var progressPercent = Math.ceil((uploadInfo.bytesRead / uploadInfo.totalSize) * 100);

        document.getElementById('progressBarText2').innerHTML = 'upload em progresso: ' + progressPercent + '%';

        document.getElementById('progressBarBoxContent2').style.width = parseInt(progressPercent * 3.0) + 'px';

        window.setTimeout('refreshProgress2()', 1000);
	
    }

    return true;
}

function startProgress2()
{
    document.getElementById('campoArquivo2').style.display = 'none';
	document.getElementById('progressBar2').style.display = 'block';
    document.getElementById('progressBarText2').innerHTML = 'upload em progresso: 0%';

    // wait a little while to make sure the upload has started ..
	
    window.setTimeout("refreshProgress2()", 1500);
    return true;
}

function limpaProgress2()
{
	document.getElementById('campoArquivo2').style.display = "";
	document.getElementById('progressBar2').style.display = "none";
	document.getElementById('progressBarText2').innerHTML = "";
	document.getElementById('progressBarBoxContent2').style.width = "";
}

function refreshProgress3()
{
	
     UploadMonitor.getUploadInfo(updateProgress3);
}

function updateProgress3(uploadInfo)
{
   
	if (uploadInfo.inProgress)
    {
        var fileIndex = uploadInfo.fileIndex;

        var progressPercent = Math.ceil((uploadInfo.bytesRead / uploadInfo.totalSize) * 100);

        document.getElementById('progressBarText3').innerHTML = 'upload em progresso: ' + progressPercent + '%';

        document.getElementById('progressBarBoxContent3').style.width = parseInt(progressPercent * 3.0) + 'px';

        window.setTimeout('refreshProgress3()', 1000);
	
    }

    return true;
}

function startProgress3()
{
    document.getElementById('campoArquivo3').style.display = 'none';
	document.getElementById('progressBar3').style.display = 'block';
    document.getElementById('progressBarText3').innerHTML = 'upload em progresso: 0%';

    // wait a little while to make sure the upload has started ..
	
    window.setTimeout("refreshProgress3()", 1500);
    return true;
}

function limpaProgress3()
{
	document.getElementById('campoArquivo3').style.display = "";
	document.getElementById('progressBar3').style.display = "none";
	document.getElementById('progressBarText3').innerHTML = "";
	document.getElementById('progressBarBoxContent3').style.width = "";
}

function refreshProgress4()
{
	
     UploadMonitor.getUploadInfo(updateProgress4);
}

function updateProgress4(uploadInfo)
{
   
	if (uploadInfo.inProgress)
    {
        var fileIndex = uploadInfo.fileIndex;

        var progressPercent = Math.ceil((uploadInfo.bytesRead / uploadInfo.totalSize) * 100);

        document.getElementById('progressBarText4').innerHTML = 'upload em progresso: ' + progressPercent + '%';

        document.getElementById('progressBarBoxContent4').style.width = parseInt(progressPercent * 3.0) + 'px';

        window.setTimeout('refreshProgress4()', 1000);
	
    }

    return true;
}

function startProgress4()
{
    document.getElementById('campoArquivo4').style.display = 'none';
	document.getElementById('progressBar4').style.display = 'block';
    document.getElementById('progressBarText4').innerHTML = 'upload em progresso: 0%';

    // wait a little while to make sure the upload has started ..
	
    window.setTimeout("refreshProgress4()", 1500);
    return true;
}

function limpaProgress4()
{
	document.getElementById('campoArquivo4').style.display = "";
	document.getElementById('progressBar4').style.display = "none";
	document.getElementById('progressBarText4').innerHTML = "";
	document.getElementById('progressBarBoxContent4').style.width = "";
}


function refreshProgress5()
{
	
     UploadMonitor.getUploadInfo(updateProgress5);
}

function updateProgress5(uploadInfo)
{
   
	if (uploadInfo.inProgress)
    {
        var fileIndex = uploadInfo.fileIndex;

        var progressPercent = Math.ceil((uploadInfo.bytesRead / uploadInfo.totalSize) * 100);

        document.getElementById('progressBarText5').innerHTML = 'upload em progresso: ' + progressPercent + '%';

        document.getElementById('progressBarBoxContent5').style.width = parseInt(progressPercent * 3.0) + 'px';

        window.setTimeout('refreshProgress5()', 1000);
	
    }

    return true;
}

function startProgress5()
{
    document.getElementById('campoArquivo5').style.display = 'none';
	document.getElementById('progressBar5').style.display = 'block';
    document.getElementById('progressBarText5').innerHTML = 'upload em progresso: 0%';

    // wait a little while to make sure the upload has started ..
	
    window.setTimeout("refreshProgress5()", 1500);
    return true;
}

function limpaProgress5()
{
	document.getElementById('campoArquivo5').style.display = "";
	document.getElementById('progressBar5').style.display = "none";
	document.getElementById('progressBarText5').innerHTML = "";
	document.getElementById('progressBarBoxContent5').style.width = "";
}

function refreshProgress6()
{
	
     UploadMonitor.getUploadInfo(updateProgress6);
}

function updateProgress6(uploadInfo)
{
   
	if (uploadInfo.inProgress)
    {
        var fileIndex = uploadInfo.fileIndex;

        var progressPercent = Math.ceil((uploadInfo.bytesRead / uploadInfo.totalSize) * 100);

        document.getElementById('progressBarText6').innerHTML = 'upload em progresso: ' + progressPercent + '%';

        document.getElementById('progressBarBoxContent6').style.width = parseInt(progressPercent * 3.0) + 'px';

        window.setTimeout('refreshProgress6()', 1000);
	
    }

    return true;
}

function startProgress6()
{
    document.getElementById('campoArquivo6').style.display = 'none';
	document.getElementById('progressBar6').style.display = 'block';
    document.getElementById('progressBarText6').innerHTML = 'upload em progresso: 0%';

    // wait a little while to make sure the upload has started ..
	
    window.setTimeout("refreshProgress6()", 1500);
    return true;
}

function limpaProgress6()
{
	document.getElementById('campoArquivo6').style.display = "";
	document.getElementById('progressBar6').style.display = "none";
	document.getElementById('progressBarText6').innerHTML = "";
	document.getElementById('progressBarBoxContent6').style.width = "";
}
