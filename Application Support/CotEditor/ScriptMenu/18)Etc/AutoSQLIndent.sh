#!/opt/local/bin/js
// %%%{CotEditorXInput=Selection}%%%
// %%%{CotEditorXOutput=ReplaceSelection}%%%

var l = '';
var selectedText = '';
while (l = readline()) {
    selectedText += l;
}

/*********************************************************************
/ * �e��萔��`
/ *********************************************************************/
/*
 * �������
 */
CNS_NORMAL=0; // �ʏ���
CNS_CHAR=1; // SQL���̕������\����ʁu' �c '�v
CNS_DC=2; // SQL���̕������\����ʁu" �c "�v
CNS_COMMENT_1=3; // SQL���̃R�����g��\����ʁu/* �c */�v
CNS_COMMENT_2=4; // SQL���̃R�����g��\����ʁu-- �c �v
CNS_HINT=5; // SQL���̃q���g���\����ʁu/*+ �c */ �v
CNS_RM=-1; // �����ΏۂƂȂ镶����\�����

print (fixSQL(selectedText));

quit();

/*********************************************************************
 * �֐���`
 *********************************************************************/
/*
 * �ŐV�o�[�W�����擾
 */
function getLastVer() {
	var str;
	str = "Ver 1.00";
	return str;
}

/*
 * SQL���`�������s
 */
function doExec() {
	var sqltext;

	// ���`����SQL�����擾����B
	sqltext = fixSQL(getSQLTextValue());

	// ���`����SQL����"SQLFORM"�ɐݒ肷��B
	setSQLTextValue(sqltext);
}

/*
 * "SQLFORM"�̋L�ړ��e���擾
 */
function getSQLTextValue() {
	return document.SQLFORM.SQLText.value;
}

/*
 * "SQLFORM"�̋L�ړ��e���X�V
 */
function setSQLTextValue(val) {
	document.SQLFORM.SQLText.value=val;
}

/*
 * ChangeCase���W�I�{�^���̑I����Ԏ擾
 */
function getChangeCase() {
    // �啶���ϊ�
    return "UCase";
    // �������ϊ�
    //return "LCase";
    // �ϊ��Ȃ�
    //return "NOChange";
}

/*
 * CommaPos���W�I�{�^���̑I����Ԏ擾
 */
function getCommaPos() {
	// �u,�v�J���}���s���ɔz�u����
	return "Top";
	// �u,�v�J���}���s���ɔz�u����
	//return "End";
}

/*
 * AndPos���W�I�{�^���̑I����Ԏ擾
 */
function getAndPos() {
	// WHERE��́uAND�v�A�uOR�v���s���ɔz�u����
	return "Top";
	// WHERE��́uAND�v�A�uOR�v���s���ɔz�u����
	//return "End";
}

/*
 * CommentPos���W�I�{�^���̑I����Ԏ擾
 */
function getCommentPos() {
	var ret;
	if(document.CommentRadio==undefined) {
		return "Top";
	}
	if(document.CommentRadio[0].checked==true){
		ret=document.CommentRadio[0].value;
	}else if(document.CommentRadio[1].checked==true){
		ret=document.CommentRadio[1].value;
	}
    return ret;
}

/*
 * TabSelect�Z���N�g���X�g�̑I����Ԏ擾
 */
function getTabSelect() {
    // �^�u��
	return 4;
}

/*
 * �C���f���g���쐬
 */
function makeTabSpace(iLevel,tabSize) {
	// �n�[�h�^�u���g���������͈ȉ��̍s���A���R�����g���Ă�������
	//return "�_t";
	var ret;
	ret="";
	for(i=0;i<(iLevel*tabSize);i++) {
		ret=ret+" ";
	}
	return ret;
}

/*
 * �e�L�X�g�̃T�C�Y�̏�����
 */
function intTextAreaSize(textAreaName) {
	// �s���F20
	textAreaName.rows=20;
	// �񐔁F80
	textAreaName.cols=80;
	// �e�L�X�g�G���A�T�C�Y�̕\��
	writeTextAreaSize(textAreaName);
}

/*
 * �e�L�X�g�̃T�C�Y�ύX
 */
function ChangeTextAreaSize(textAreaName,pRowSize,pClmSize){
	// �s���̑���
	if((textAreaName.rows+pRowSize)>=10) {
		textAreaName.rows=textAreaName.rows+pRowSize;
	}
	// �񐔂̑���
	if((textAreaName.cols+pClmSize)>=10) {
		textAreaName.cols=textAreaName.cols+pClmSize;
	}
	// �e�L�X�g�G���A�T�C�Y�̕\��
	writeTextAreaSize(textAreaName);
}

/*
 * SQL�e�L�X�g�G���A�̃T�C�Y�\��
 */
function writeTextAreaSize(textAreaName){
	if(document.getElementById) {
		//e5,e6,n6,n7,m1,o7,s1�p
		document.getElementById("RowColumns").innerHTML="Rows�F"+textAreaName.rows+"/Cols�F"+textAreaName.cols;
	}else if(document.all){
		//e4�p
		document.all("RowColumns").innerHTML="Rows�F"+textAreaName.rows+"/Cols�F"+textAreaName.cols;
	}else if(document.layers) {
		//n4�p
		with(document.layers['RowColumns'].document){
		open();
		write("Rows�F"+textAreaName.rows+"/Cols�F"+textAreaName.cols);
		close();
		}
	}
}

/*
 * ���A�h�߂�
 */
function GettingMailAddress() {
	var str;
	str = "<a href=\"mailto:&#105nf&#111&#64&#115e&#105&#106&#105&#45t&#115ub&#111&#115ak&#105&#46net\"  TITLE=\"��҂փ��[�����܂��B\">���[��</a>�@���@���ӌ��E�����z�����������Ă���܂��B";
	return str;
}

/*
 * CopyRight�쐬
 */
function CopyRightString() {
	var str;
	str = "copyright(c) SEIJI TSUBOSAKI 2007 all rights reserved.";
	return str;
}

/*
 * �E�[����w�蕶�������o��
 */
function substrRight(str,n) {
	var ret;
	ret=str.substr(str.length-n,n);
    return ret;
}

/*
 * ���[����w�蕶�������o��
 */
function substrLeft(str,n) {
	var ret;
	ret=str.substr(0,n);
    return ret;
}

/*
 * ������̈ꕔ��u��
 */
function changeStr(str1,n,str2) {
	var ret;
	ret=substrLeft(str1,n-1)+str2+substrRight(str1,str1.length-n);
    return ret;
}

/*
 * ���[�̋󔒂���������
 */
function trimLR(str) {
    return trimR( trimL( str ) );
}

/*
 * ���[�̋󔒂���������
 */
function trimL(str) {
    var x;
    for(x=0; str.charCodeAt(x) < 33 && x < str.length; x++);
    return str.substring(x, str.length);
}

/*
 * �E�[�̋󔒂���������
 */
function trimR(str) {
    var x;
    for(x = str.length; str.charCodeAt(--x) < 33 && x > 0; );
    return str.substring(0, x + 1);
}

/*
 * n�̃����o�����z����쐬
 */
function makeArray(n) {
	var i;
	this.length=n;
	for(i=0;i<n;i++) {
		this[i]="";
	}
	return this;
}

/*
 * SQL�����\�����镶���̑������쐬
 * chr �c SQL���\�����镶�����̂���
 * typ �c SQL���\�����镶���̕������
 * idtf �c SQL���\�����镶���̃C���f���g���(�O)
 * idtb �c SQL���\�����镶���̃C���f���g���(��)
 */
function SQLCharAttribute(chr, typ, idtf, idtb) {
	this.chr = chr;
	this.typ = typ;
	this.idtf = idtf;
	this.idtb = idtb;
}

/*
 * SQL�����\�����镶���̑����z��̊g��
 * pSqlChr �c SQL���\�����镶���̑����z��
 * p �c �z��g����̔Ԓn
 * n �c �z��g����
 */
function resizeSQLCharAttribute(pSqlChr, p, n) {
	var i;
	retSqlChr = new makeArray(pSqlChr.length+n);
	for (i=0;i<p;i++) {
		retSqlChr[i]=pSqlChr[i];
	}
	for (i=p;i<p+n;i++) {
		retSqlChr[i]=new SQLCharAttribute("", "", "", "");
	}
	for (i=p+n;i<=retSqlChr.length;i++) {
		retSqlChr[i]=pSqlChr[i-n];
	}
	return retSqlChr;
}

/*
 * SQL�����\������L�[���[�h�̔Ԓn����
 * pSqlChr �c SQL���\������L�[���[�h�̑���
 * typ �c SQL���\�����镶���̕������
 * s �c �����J�n
 * p �c �����Ώ�
 */
function searchSQLKeyWordPos(pSqlChr,typ,s,p) {
	var i;
	var cnt;
	cnt=0;
	if(p>0) {
		for(i=s;i<=pSqlChr.length;i++) {
			if(pSqlChr[i].typ==typ) {
				cnt=cnt+1;
				if(cnt==p) {
					return i;
				}
			}
		}
	}else {
		for (i=s;i>=1;i--) {
			if(pSqlChr[i].typ==typ) {
				cnt=cnt+1;
				if(cnt==(-1*p)) {
					return i;
				}
			}
		}
	}
	return 0;
}

/*
 * SQL�����\������L�[���[�h�̌���
 * pSqlChr �c SQL���\������L�[���[�h�̑���
 * typ �c SQL���\�����镶���̕������
 * s �c �����J�n
 * p �c �����Ώ�
 */
function searchSQLKeyWordChr(pSqlChr,typ,s,p) {
	var i;
	var cnt;
	cnt=0;
	if(p>0) {
		for(i=s;i<=pSqlChr.length;i++) {
			if(pSqlChr[i].typ==typ) {
				cnt=cnt+1;
				if(cnt==p) {
					return pSqlChr[i].chr;
				}
			}
		}
	}else {
		for (i=s;i>=1;i--) {
			if(pSqlChr[i].typ==typ) {
				cnt=cnt+1;
				if(cnt==(-1*p)) {
					return pSqlChr[i].chr;
				}
			}
		}
	}
	return "";
}

/*
 * SQL���R�}���h�̔Ԓn����
 * pSqlChr �c SQL���\������L�[���[�h�̑���
 * s �c �����J�n
 * p �c �����Ώ�
 */
function searchSQLCommandPos(pSqlChr,s,p) {
	var i;
	var cnt;
	cnt=0;
	if(p>0) {
		for(i=s;i<=pSqlChr.length;i++) {
			if(pSqlChr[i].chr.toUpperCase()=="SELECT"
				|| pSqlChr[i].chr.toUpperCase()=="INSERT"
				|| pSqlChr[i].chr.toUpperCase()=="DELETE"
				|| pSqlChr[i].chr.toUpperCase()=="UPDATE"
				|| pSqlChr[i].chr.toUpperCase()=="MERGE"
				|| pSqlChr[i].chr.toUpperCase()=="CREATE"
				|| pSqlChr[i].chr.toUpperCase()=="ALTER"
				|| pSqlChr[i].chr.toUpperCase()=="FROM") {
				cnt=cnt+1;
				if(cnt==p) {
					return i;
				}
			}
		}
	}else {
		for (i=s;i>=1;i--) {
			if(pSqlChr[i].chr.toUpperCase()=="SELECT"
				|| pSqlChr[i].chr.toUpperCase()=="INSERT"
				|| pSqlChr[i].chr.toUpperCase()=="DELETE"
				|| pSqlChr[i].chr.toUpperCase()=="UPDATE"
				|| pSqlChr[i].chr.toUpperCase()=="MERGE"
				|| pSqlChr[i].chr.toUpperCase()=="CREATE"
				|| pSqlChr[i].chr.toUpperCase()=="ALTER"
				|| pSqlChr[i].chr.toUpperCase()=="FROM") {
				cnt=cnt+1;
				if(cnt==(-1*p)) {
					return i;
				}
			}
		}
	}
	return 0;
}

/*
 * SQL���R�}���h�̌���
 * pSqlChr �c SQL���\������L�[���[�h�̑���
 * s �c �����J�n
 * p �c �����Ώ�
 */
function searchSQLCommandChr(pSqlChr,s,p) {
	var i;
	var cnt;
	cnt=0;
	if(p>0) {
		for(i=s;i<=pSqlChr.length;i++) {
			if(pSqlChr[i].chr.toUpperCase()=="SELECT"
				|| pSqlChr[i].chr.toUpperCase()=="INSERT"
				|| pSqlChr[i].chr.toUpperCase()=="DELETE"
				|| pSqlChr[i].chr.toUpperCase()=="UPDATE"
				|| pSqlChr[i].chr.toUpperCase()=="MERGE"
				|| pSqlChr[i].chr.toUpperCase()=="CREATE"
				|| pSqlChr[i].chr.toUpperCase()=="ALTER"
				|| pSqlChr[i].chr.toUpperCase()=="VALUES") {
				cnt=cnt+1;
				if(cnt==p) {
					return pSqlChr[i].chr;
				}
			}
		}
	}else {
		for (i=s;i>=1;i--) {
			if(pSqlChr[i].chr.toUpperCase()=="SELECT"
				|| pSqlChr[i].chr.toUpperCase()=="INSERT"
				|| pSqlChr[i].chr.toUpperCase()=="DELETE"
				|| pSqlChr[i].chr.toUpperCase()=="UPDATE"
				|| pSqlChr[i].chr.toUpperCase()=="MERGE"
				|| pSqlChr[i].chr.toUpperCase()=="CREATE"
				|| pSqlChr[i].chr.toUpperCase()=="ALTER"
				|| pSqlChr[i].chr.toUpperCase()=="VALUES") {
				cnt=cnt+1;
				if(cnt==(-1*p)) {
					return pSqlChr[i].chr;
				}
			}
		}
	}
	return "";
}

/*
 * �V�[�P���X�I�u�W�F�N�g�쐬�L�[���[�h�̃`�F�b�N
 * str �c �L�[���[�h
 */
function checkSequenceKey(str) {
	if(str.toUpperCase()=="INCREMENT"
		|| str.toUpperCase()=="START"
		|| str.toUpperCase()=="MAXVALUE"
		|| str.toUpperCase()=="NOMAXVALUE"
		|| str.toUpperCase()=="MINVALUE"
		|| str.toUpperCase()=="NOMINVALUE"
		|| str.toUpperCase()=="CYCLE"
		|| str.toUpperCase()=="NOCYCLE"
		|| str.toUpperCase()=="CACHE"
		|| str.toUpperCase()=="NOCACHE"
		|| str.toUpperCase()=="NOORDER") {
		return 1;
	}else {
		return 0;
	}
}


/*
 * ���[�U�쐬�L�[���[�h�̃`�F�b�N
 * str �c �L�[���[�h
 */
function checkUserKey(str) {
	if(str.toUpperCase()=="IDENTIFIED"
		|| str.toUpperCase()=="DEFAULT"
		|| str.toUpperCase()=="TEMPORARY"
		|| str.toUpperCase()=="QUOTA"
		|| str.toUpperCase()=="PROFILE"
		|| str.toUpperCase()=="PASSWORD"
		|| str.toUpperCase()=="ACCOUNT") {
		return 1;
	}else {
		return 0;
	}
}

/*
 * CREATE TABLE�쐬�L�[���[�h�̃`�F�b�N
 * str �c �L�[���[�h
 */
function checkCreateTableKey(str) {
	if(str.toUpperCase()=="TABLESPACE"
		|| str.toUpperCase()=="ENABLE"
		|| str.toUpperCase()=="DISABLE"
		|| str.toUpperCase()=="CHUNK"
		|| str.toUpperCase()=="PCTVERSION"
		|| str.toUpperCase()=="RETENTION"
		|| str.toUpperCase()=="FREEPOOLS"
		|| str.toUpperCase()=="CACHE"
		|| str.toUpperCase()=="NOCACHE"
		|| str.toUpperCase()=="LOGGING"
		|| str.toUpperCase()=="NOLOGGING"
		|| str.toUpperCase()=="PARTITION"
		|| str.toUpperCase()=="SUBPARTITION"
		|| str.toUpperCase()=="COMPRESS"
		|| str.toUpperCase()=="NOCOMPRESS"
		|| str.toUpperCase()=="PCTFREE"
		|| str.toUpperCase()=="PCTUSED"
		|| str.toUpperCase()=="INITRANS"
		|| str.toUpperCase()=="MAXTRANS"
		|| str.toUpperCase()=="INCLUDING") {
		return 1;
	}else {
		return 0;
	}
}

/*
 * SQL���ߕ�����̉��s�ʒu�����肷��
 * pSqlChr �c SQL���\������L�[���[�h�̑���
 */
function judgeLineFeed(pSqlChr) {
	if(pSqlChr.typ==CNS_NORMAL
		&& (
				pSqlChr.chr.toUpperCase()=="DISTINCT"
			||  pSqlChr.chr.toUpperCase()=="UNIQUE"
			||  pSqlChr.chr.toUpperCase()=="ALL"
			||  pSqlChr.chr.toUpperCase()=="INTO" )) {
		return 0;
	}else if(pSqlChr.typ==CNS_HINT) {
		return 0;
	}else if(pSqlChr.typ==CNS_COMMENT_1) {
		return 0;
	}else {
		return 1;
	}
}

/*
 * SQL�����\�����镶���̑����z��̏�����
 * pSql    �c SQL��
 * pSqlChr �c SQL���\�����镶���̑����z��
 */
function initSQLCharAttribute(pSQL,pSqlChr) {
	var i; // �P���ȃ��[�v�J�E���^�B
	var sqlLength; // pSqlChr�z��̗L���T�C�Y��\���ϐ�
	// pSqlChr�z��̗L���T�C�Y��\���ϐ���1�ŏ���������B
	sqlLength=1;
	var wkKind; // SQL�̕�����ʊi�[�p�ϐ�
	// SQL�̕�����ʊi�[�p�ϐ���ʏ��ʂŏ���������B
	wkKind=CNS_NORMAL;

	// SQL�����\�����镶���̑����z���pSQL�̒����ŏ���������B
	pSqlChr=new makeArray(pSQL.length);

	// pSQL���ꕶ�����Q�Ƃ��āASQL�����\�����镶���̑����z����쐬����B
	// �y���[���P�z sql����؂�o�������������s�̏ꍇ�A" "�ɕϊ�����B
	// �y���[���Q�z sql����؂�o����������"("�A")"�A","�A";"�A"+"�A"-"�̂����ꂩ�̏ꍇ�͂��̑O���" "��}������B
	// �y���[���R�z sql����؂�o����������"�^�u"�̏ꍇ�A" "�ɕϊ�����B
	// �y���[���S�z�A���A�ȉ���4�p�^�[���ɊY������ꍇ�̓��[���P�`�R�͓K�����Ȃ��B
	//   1)�u'�v�ɋ��܂�镶����̈ꕔ�ł���ꍇ
	//   2)�u"�v�ɋ��܂�镶����̈ꕔ�ł���ꍇ
	//   3)�u/*�v�Ɓu*/�v�ɋ��܂�镶����̈ꕔ�ł���ꍇ
	//   4)�u--�v�ƁA���̌��Ɍ����ŏ��̉��s�ɋ��܂�镶����̈ꕔ�ł���ꍇ
	for (i=0;i<pSQL.length;i++) {
		sqlLength=sqlLength+1;
		if(wkKind==CNS_NORMAL) {
			if(pSQL.charAt(i)=="'") {
				wkKind=CNS_CHAR;
				pSqlChr[sqlLength-1]=new SQLCharAttribute(pSQL.charAt(i), wkKind, "", "");
			}else if(pSQL.charAt(i)=="\"") {
				wkKind=CNS_DC;
				pSqlChr[sqlLength-1]=new SQLCharAttribute(pSQL.charAt(i), wkKind, "", "");
			}else if(i<(pSQL.length-2) && pSQL.charAt(i)=="/" && pSQL.charAt(i+1)=="*" && pSQL.charAt(i+2)=="+") {
				sqlLength=sqlLength+1;
				pSqlChr=resizeSQLCharAttribute(pSqlChr,sqlLength-1,1);
				pSqlChr[sqlLength-2]=new SQLCharAttribute(" ", wkKind, "", "");
				wkKind=CNS_HINT;
				pSqlChr[sqlLength-1]=new SQLCharAttribute(pSQL.charAt(i), wkKind, "", "");
			}else if(i<(pSQL.length-1) && pSQL.charAt(i)=="/" && pSQL.charAt(i+1)=="*") {
				sqlLength=sqlLength+1;
				pSqlChr=resizeSQLCharAttribute(pSqlChr,sqlLength-1,1);
				pSqlChr[sqlLength-2]=new SQLCharAttribute(" ", wkKind, "", "");
				wkKind=CNS_COMMENT_1;
				pSqlChr[sqlLength-1]=new SQLCharAttribute(pSQL.charAt(i), wkKind, "", "");
			}else if(i<(pSQL.length-1) && pSQL.charAt(i)=="-" && pSQL.charAt(i+1)=="-") {
				sqlLength=sqlLength+1;
				pSqlChr=resizeSQLCharAttribute(pSqlChr,sqlLength-2,1);
				pSqlChr[sqlLength-2]=new SQLCharAttribute(" ", wkKind, "", "");
				wkKind=CNS_COMMENT_2;
				// i�́A0�X�^�[�g�Ȃ̂ŁA1�����B
				//pSQL=changeStr(pSQL,i+(1),"/");
				//pSQL=changeStr(pSQL,i+1+(1),"*");
				pSqlChr[sqlLength-1]=new SQLCharAttribute(pSQL.charAt(i), wkKind, "", "");
			}else if(pSQL.charAt(i)=="\r") {
				pSqlChr[sqlLength-1]=new SQLCharAttribute(" ", wkKind, "", "");
			}else if(pSQL.charAt(i)=="\n") {
				pSqlChr[sqlLength-1]=new SQLCharAttribute(" ", wkKind, "", "");
			}else if(pSQL.charAt(i)=="\t") {
				pSqlChr[sqlLength-1]=new SQLCharAttribute(" ", wkKind, "", "");
			}else if(pSQL.charAt(i)=="(" || pSQL.charAt(i)==")" || pSQL.charAt(i)=="," || pSQL.charAt(i)==";" || pSQL.charAt(i)=="/" || pSQL.charAt(i)=="+" || pSQL.charAt(i)=="-") {
				// �O���" "��}������pSqlChr���쐬����̂ł���ɃT�C�Y�g������B
				pSqlChr=resizeSQLCharAttribute(pSqlChr,sqlLength-1,2);
				// sqlLength��+2���Ă����B
				sqlLength=sqlLength+2; 
				pSqlChr[sqlLength-3]=new SQLCharAttribute(" ", wkKind, "", "");
				pSqlChr[sqlLength-2]=new SQLCharAttribute(pSQL.charAt(i), wkKind, "", "");
				pSqlChr[sqlLength-1]=new SQLCharAttribute(" ", wkKind, "", "");
			}else if(i<(pSQL.length-1) && pSQL.charAt(i)=="|" && pSQL.charAt(i+1)=="|") {
				// �����A���L��"||"�����o����B
				sqlLength=sqlLength+1;
				pSqlChr=resizeSQLCharAttribute(pSqlChr,sqlLength-2,1);
				pSqlChr[sqlLength-2]=new SQLCharAttribute(" ", wkKind, "", "");
				pSqlChr[sqlLength-1]=new SQLCharAttribute(pSQL.charAt(i), wkKind, "", "");
			}else if(i>1 && pSQL.charAt(i-1)=="|" && pSQL.charAt(i)=="|") {
				// �����A���L��"||"�����o����B
				sqlLength=sqlLength+1;
				pSqlChr=resizeSQLCharAttribute(pSqlChr,sqlLength-2,1);
				pSqlChr[sqlLength-2]=new SQLCharAttribute(pSQL.charAt(i), wkKind, "", "");
				pSqlChr[sqlLength-1]=new SQLCharAttribute(" ", wkKind, "", "");
			}else {
				pSqlChr[sqlLength-1]=new SQLCharAttribute(pSQL.charAt(i), wkKind, "", "");
			}
		}else {
			pSqlChr[sqlLength-1]=new SQLCharAttribute(pSQL.charAt(i), wkKind, "", "");
			if(wkKind==CNS_CHAR && i==(pSQL.length-1) && pSQL.charAt(i)=="'") {
				wkKind=CNS_NORMAL;
			}else if(wkKind==CNS_DC && pSQL.charAt(i)=="\"") {
				wkKind=CNS_NORMAL;
			}else if(wkKind==CNS_CHAR && i<(pSQL.length-1) && pSQL.charAt(i)=="'" && pSQL.charAt(i+1)!="'") {
				wkKind=CNS_NORMAL;
			}else if(wkKind==CNS_HINT && pSQL.charAt(i-1)=="*" && pSQL.charAt(i)=="/") {
				// �q���g����ӎ�����ׂɁA/*+ �c */�̌���" "��}������pSqlChr���쐬����B
				//sqlLength=sqlLength+1;
				//pSqlChr=resizeSQLCharAttribute(pSqlChr,sqlLength-1,1);
				//pSqlChr[sqlLength-1]=new SQLCharAttribute(" ", wkKind, "", "");
				wkKind=CNS_NORMAL;
				sqlLength=sqlLength+1;
				pSqlChr=resizeSQLCharAttribute(pSqlChr,sqlLength-1,1);
				pSqlChr[sqlLength-1]=new SQLCharAttribute(" ", wkKind, "", "");
			}else if(wkKind==CNS_COMMENT_1 && pSQL.charAt(i-1)=="*" && pSQL.charAt(i)=="/") {
				wkKind=CNS_NORMAL;
				sqlLength=sqlLength+1;
				pSqlChr=resizeSQLCharAttribute(pSqlChr,sqlLength-1,1);
				pSqlChr[sqlLength-1]=new SQLCharAttribute(" ", wkKind, "", "");
			}else if(wkKind==CNS_COMMENT_2 && pSQL.charAt(i)=="\n") {
				//sqlLength=sqlLength+1;
				//pSqlChr=resizeSQLCharAttribute(pSqlChr,sqlLength-1,1);
				//pSqlChr[sqlLength-1]=new SQLCharAttribute(" ", wkKind, "", "");
				//pSqlChr[sqlLength-2].chr="\r\n";
				//pSqlChr[sqlLength-1].chr="";
				pSqlChr[sqlLength-2].chr="\r\n";
				pSqlChr[sqlLength-1].chr="";
				wkKind=CNS_NORMAL;
			}
		}
	}
	// �쐬����SQL�����\�����镶���̑����z����ďo���ɖ߂��B
	return pSqlChr;
}

/*
 * SQL�����\���L�[���[�h�̑����z��̏�����
 * pSqlChr �c SQL���\�����镶���̑����z��
 */
function initSQLKeyWordAttribute(pSqlChr) {
	var i; // �P���ȃ��[�v�J�E���^�B
	var sqlLength; // pSqlChr�z��̗L���T�C�Y��\���ϐ�
	// pSqlChr�z��̗L���T�C�Y��ϐ��Ɏ擾����B
	sqlLength=pSqlChr.length;

	// SQL���̃L�[���[�h�̑����z���錾����B
	sqlKeyWordChr=new makeArray(0);

	var workKeyWord; // �L�[���[�h�쐬�p�ϐ�
	workKeyWord=""; // �L�[���[�h�쐬�p�ϐ��̏�����

	var idx; // �L�[���[�h�擪�̔Ԓn��ێ�����ϐ��B
	idx=0; // �L�[���[�h�擪�̔Ԓn��ێ�����ϐ��̏�����

	sqlKeyWordChr[0]=new SQLCharAttribute("", "", "", "");

	// pSQL���ꕶ�����Q�Ƃ��āASQL�����\�����镶���̑����z����쐬����B
	for (i=1;i<=sqlLength;i++) {
		if(pSqlChr[i].typ==CNS_NORMAL && pSqlChr[i].chr==" " && workKeyWord!="") {
			// �L�[���[�h�̋�؂�̔���
			// sqlKeyWordChr�̃T�C�Y�g������B
			sqlKeyWordChr=resizeSQLCharAttribute(sqlKeyWordChr,sqlKeyWordChr.length+1,1);
			// �L�[���[�h�z��̍쐬
			sqlKeyWordChr[sqlKeyWordChr.length]=new SQLCharAttribute(workKeyWord, pSqlChr[idx].typ, "", "");
			// �L�[���[�h�쐬�p�ϐ��̏�����
			workKeyWord="";
		}else if(pSqlChr[i].typ==CNS_COMMENT_2 && pSqlChr[i].chr=="\r\n" && workKeyWord!="") {
			// �L�[���[�h�̋�؂�̔���
			// sqlKeyWordChr�̃T�C�Y�g������B
			sqlKeyWordChr=resizeSQLCharAttribute(sqlKeyWordChr,sqlKeyWordChr.length+1,1);
			// �L�[���[�h�z��̍쐬
			sqlKeyWordChr[sqlKeyWordChr.length]=new SQLCharAttribute(workKeyWord, pSqlChr[idx].typ, "", "\r\n");
			// �L�[���[�h�쐬�p�ϐ��̏�����
			workKeyWord="";

		}else if(pSqlChr[i].typ!=CNS_RM){
			if(workKeyWord=="") {
				idx=i;
			}
			// �L�[���[�h���쐬����B
			workKeyWord=workKeyWord+pSqlChr[i].chr;
		}
		// ���p�X�y�[�X�̋󔒁A���s�̖���
		if(workKeyWord==" " || workKeyWord=="\r\n"){
			workKeyWord="";
			idx=0;
		}else {
		}
	}

	if(workKeyWord!="") {
		// �L�[���[�h�̋�؂�̔���
		// sqlKeyWordChr�̃T�C�Y�g������B
		sqlKeyWordChr=resizeSQLCharAttribute(sqlKeyWordChr,sqlKeyWordChr.length+1,1);
		// �L�[���[�h�z��̍쐬
		sqlKeyWordChr[sqlKeyWordChr.length]=new SQLCharAttribute(workKeyWord, pSqlChr[idx].typ, "", "");
		// �L�[���[�h�쐬�p�ϐ��̏�����
		workKeyWord="";
	}

	// �쐬����SQL�����\�����镶���̑����z����ďo���ɖ߂��B
	return sqlKeyWordChr;
}

/*
 * �A������" "������
 * pSqlChr �c SQL���\�����镶���̑����z��
 */
function rmSpaceFromSQLChar(pSqlChr) {
	var i; // ���[�v�����Ŏg�p����P���ȃJ�E���^
	for(i=0;i<=(pSqlChr.length-1);i++) {
		if(pSqlChr[i].typ==CNS_NORMAL && pSqlChr[i+1].typ==CNS_NORMAL) {
			if(pSqlChr[i].chr==" " && pSqlChr[i+1].chr==" ") {
				pSqlChr[i].typ=CNS_RM;
			}
		}
	}
	// �쐬����SQL�����\�����镶���̑����z����ďo���ɖ߂��B
	return pSqlChr;
}

/*
 * ��ʂɏ]���啶��/�������ϊ�
 * pSqlChr �c SQL���\�����镶���̑����z��
 */
function changeCaseFromSQLChar(pSqlChr) {
	var i; // ���[�v�����Ŏg�p����P���ȃJ�E���^
	for(i=0;i<=pSqlChr.length;i++) {
		if(getChangeCase()=="UCase") {
			if(pSqlChr[i].typ==CNS_NORMAL) {
				pSqlChr[i].chr=pSqlChr[i].chr.toUpperCase();
			}
		} else if(getChangeCase()=="LCase") {
			if(pSqlChr[i].typ==CNS_NORMAL) {
				pSqlChr[i].chr=pSqlChr[i].chr.toLowerCase();
			}
		}
	}
	// �쐬����SQL�����\�����镶���̑����z����ďo���ɖ߂��B
	return pSqlChr;
}

/*
 * SQL���\�����镶���̑����z��̎w��Ԓn��蒼�O�̗L�������Ԓn�擾
 * pSqlChr �c SQL���\�����镶���̑����z��
 * pos     �c �w��Ԓn
 */
function searchPreChr(pSqlChr,pos) {
	var i; // ���[�v�����Ŏg�p����P���ȃJ�E���^
	for(i=pos-3;i>=0;i--) {
		if(pSqlChr[i].typ==CNS_NORMAL && pSqlChr[i].chr!=" " && pSqlChr[i].chr!="" && pSqlChr[i].chr!="\r\n" && pSqlChr[i].chr!="\r" && pSqlChr[i].chr!="\n" && pSqlChr[i].chr!="/") {
			return i;
		}
	}
	return 0;
}

/*
 * SQL�𐮌`
 */
function fixSQL(sql) {
	// SQL���e�L�X�g�G���A�ɓ��͂���Ă��Ȃ��ꍇ�͏����𒆒f����B
	if(sql.length==0) {
		return "SQL�e�L�X�g�G���A�ɉ������͂���Ă��܂���B";
	}

	var ret; // �߂�l�쐬�p�ϐ�
	var i; var j; // ���[�v�����Ŏg�p����P���ȃJ�E���^

	var wkKind; // SQL�̕�����ʊi�[�p�ϐ�
	// SQL�̕�����ʊi�[�p�ϐ���ʏ��ʂŏ���������B
	wkKind=CNS_NORMAL;

	// SQL�����\�����镶���̑����z�������������B
	sqlChr=new makeArray();
	var sqlLength; // sqlChr�z��̗L���T�C�Y��\���ϐ�
	// sqlChr�z��̗L���T�C�Y��\���ϐ���1�ŏ���������B
	sqlLength=1;

	// sqlChr��SQL�e�L�X�g�G���A�̓��e���ꕶ������荞��(��sqlChr�̏�����)
	sqlChr=initSQLCharAttribute(sql,sqlChr);
	// SqlChr�z��̗L���T�C�Y��\���ϐ���sqlChr�̃T�C�Y�ɂ���B
	sqlLength=sqlChr.length;

	// Oracle��SQL�\����z��ɍ쐬����B
	var oracleRw=new Array();
	oracleRw=get_oracleRw();

	// �A������" "����������B
	sqlChr=rmSpaceFromSQLChar(sqlChr);

	// ��ʂɏ]���啶��/�������ϊ�����B
	sqlChr=changeCaseFromSQLChar(sqlChr);

	var indentArr=new Array(); // �C���f���g�ݒ���s���ׂ̔z��

	var indCnt; // �C���f���g���x���J�E���g�p�ϐ�
	indCnt=0; // �C���f���g���x���J�E���g�p�ϐ��̏�����

	var parCnt; // ����"("�A")"�̃J�E���g�p�ϐ�
	parCnt=0; // ����"("�A")"�̃J�E���g�p�ϐ��̏�����

	var betweenflg; // BETWEEN�̏o�������o����ׂ̃t���O
		betweenflg=0; // BETWEEN�̏o�������o����ׂ̃t���O�̏�����

	var unionallflg; // UNION ALL�̏o�������o����ׂ̃t���O
		unionallflg=0; // UNION ALL�̏o�������o����ׂ̃t���O�̏�����

	var selectflg; // SELECT�̏o�������o����ׂ̃t���O
		selectflg=0; // SELECT�̏o�������o����ׂ̃t���O�̏�����

	var insertflg; // INSERT�̏o�������o����ׂ̃t���O
		insertflg=0; // INSERT�̏o�������o����ׂ̃t���O�̏�����

	var deleteflg; // DELETE�̏o�������o����ׂ̃t���O
	deleteflg=0; // DELETE�̏o�������o����ׂ̃t���O�̏�����

	var updateflg; // UPDATE�̏o�������o����ׂ̃t���O
	updateflg=0; // UPDATE�̏o�������o����ׂ̃t���O�̏�����

	var mergeflg; // MERGE�̏o�������o����ׂ̃t���O
		mergeflg=0; // MERGE�̏o�������o����ׂ̃t���O�̏�����

	var hintflg; // �q���g�̏o�������o����ׂ̃t���O
	hintflg=0; // �q���g�̏o�������o����ׂ̃t���O�̏�����

	var keyword; // �L�[���[�h���쐬����ׂ̕ϐ�
	keyword=""; // �L�[���[�h���쐬����ׂ̕ϐ��̏�����

	var idx; // �L�[���[�h�쐬���̐擪�C���f�b�N�X��\���ϐ�
	idx=0; // �L�[���[�h�쐬���̐擪�C���f�b�N�X��\���ϐ��̏�����

	var stopindent; // �C���f���g�}�~����ׂ̕ϐ�
	stopindent=0; // �C���f���g�}�~����ׂ̕ϐ��̏�����

	var createflg; // "CREATE"�̏o�������o����ׂ̃t���O
		createflg=0; // "CREATE"�̏o�������o����ׂ̃t���O�̏�����

	var createtableflg; // "CREATE TABLE"�̏o�������o����ׂ̃t���O
		createtableflg=0; // "CREATE TABLE"�̏o�������o����ׂ̃t���O�̏�����

	var createuserflg; // "CREATE USER"�̏o�������o����ׂ̃t���O
		createuserflg=0; // "CREATE USER"�̏o�������o����ׂ̃t���O�̏�����

	var sequenceflg; // "SEQUENCE"�̏o�������o����ׂ̃t���O
		sequenceflg=0; // "SEQUENCE"�̏o�������o����ׂ̃t���O�̏�����

	var alterflg; // "ALTER"�̏o�������o����ׂ̃t���O
	alterflg=-1; // "ALTER"�̏o�������o����ׂ̃t���O�̏�����

	var topKeyword; // SQL���̐擪�L�[���[�h
		topKeyword=""; // SQL���̐擪�L�[���[�h�̏�����

	var mergewhenflg; // "MERGE"����WHEN�̏o�������o����ׂ̃t���O
	mergewhenflg=0; // "MERGE"����WHEN�̏o�������o����ׂ̃t���O�̏�����

	var mergeonusingwhenFlg; // "MERGE"����ON/USING/WHEN�̏o�������o����ׂ̃t���O
		mergeonusingwhenFlg=0; // "MERGE"����ON/USING/WHEN�̏o�������o����ׂ̃t���O�̏�����

	var joinflg; // SQL:1999�\���̏o�������o����ׂ̃t���O
		joinflg=0; // SQL:1999�\���̏o�������o����ׂ̃t���O�̏�����

	var continueparcnt; // �A������"("�̌��o�p�ϐ�
	continueparcnt=0;

	///////////////////////////////////////////////////
	// SQL�����\������L�[���[�h�̑����z�������������B
	keywordChr=new makeArray();
	var keywordLength; // keywordChr�z��̗L���T�C�Y��\���ϐ�
	// keywordChr�z��̗L���T�C�Y��\���ϐ���1�ŏ���������B
	keywordLength=1;

	// keywordChr�ɃL�[���[�h������ݒ肷��B)
	keywordChr=initSQLKeyWordAttribute(sqlChr);
	// keywordChr�z��̗L���T�C�Y��\���ϐ���keywordLength�̃T�C�Y�ɂ���B
	keywordLength=keywordChr.length;

	// SQL���L�[���[�h�z�������Q�Ƃ���B
	for(i=1;i<=keywordLength;i++) {
		// ";"�����o���ꂽ�ꍇ�́A�C���f���g�ݒ�̃J�E���^��S�Ẵt���O�������ɖ߂��B
		if(
			(keywordChr[i].chr==";" && keywordChr[i].typ==CNS_NORMAL)
					|| (
							i>1
							&& (keywordChr[i].chr=="/" && keywordChr[i].typ==CNS_NORMAL)
							&& (keywordChr[i-1].chr==";" && keywordChr[i-1].typ==CNS_NORMAL)
						)
					|| (
							i>1
							&& (keywordChr[i].chr=="/" && keywordChr[i].typ==CNS_NORMAL)
							&& (keywordChr[i-1].chr=="/" && keywordChr[i-1].typ==CNS_NORMAL)
						)
		) {
			if (keywordChr[i-1].chr==";" && keywordChr[i-1].typ==CNS_NORMAL) {
				keywordChr[i].idtf="\r\n";
			}else {
				keywordChr[i].idtf="";
			}
			keywordChr[i].idtb="\r\n\r\n";
			topKeyword=""; // SQL���̐擪�L�[���[�h�̏�����
			indCnt=0; // �C���f���g���x���J�E���g�p�ϐ��̏�����
			parCnt=0; // ����"("�A")"�̃J�E���g�p�ϐ��̏�����
			selectflg=0; // SELECT�̏o�������o����ׂ̃t���O�̏�����
			createflg=0; // "CREATE"�̏o�������o����ׂ̃t���O�̏�����
			createtableflg=0; // "CREATE TABLE"�̏o�������o����ׂ̃t���O�̏�����
			insertflg=0; // INSERT�̏o�������o����ׂ̃t���O�̏�����
			betweenflg=0; // BETWEEN�̏o�������o����ׂ̃t���O�̏�����
			unionallflg=0; // UNION ALL�̏o�������o����ׂ̃t���O�̏�����
			joinflg=0; // SQL:1999�\���̏o�������o����ׂ̃t���O�̏�����
			sequenceflg=0; // "SEQUENCE"�̏o�������o����ׂ̃t���O�̏�����
			mergeflg=0; // MERGE�̏o�������o����ׂ̃t���O�̏�����
			mergeonusingwhenFlg=0; // "MERGE"����ON/USING/WHEN�̏o�������o����ׂ̃t���O�̏�����
			createuserflg=0; // "CREATE USER"�̏o�������o����ׂ̃t���O�̏�����
		}

		// ����"("�A")"�̊J�n�ƏI����parCnt�Œ��ׂ�B
		if(keywordChr[i].chr=="(" && keywordChr[i].typ==CNS_NORMAL) {
			parCnt=parCnt+1;
		}else if(keywordChr[i].chr==")" && keywordChr[i].typ==CNS_NORMAL) {
			parCnt=parCnt-1;
		}

		// SQL���̊Ŕ����o����B
		if(topKeyword=="" && keywordChr[i].typ==CNS_COMMENT_1 ){
			// topKeyword�����ݒ�̏�Ԃɂ���Ƃ��A�R�����g�u/* */�v�����݂��Ă���΁A�O���C���f���g�����ƁA����C���f���g�ɉ��s������B
			keywordChr[i].idtf="";
			keywordChr[i].idtb="\r\n";
		}else if(topKeyword=="" && keywordChr[i].typ==CNS_COMMENT_2 ){
			// topKeyword�����ݒ�̏�Ԃɂ���Ƃ��A�R�����g�u--�v�����݂��Ă���΁A�O���C���f���g�����B
			keywordChr[i].idtf="";
		}
		
		// "-- �c"�̃R�����g�����o����B
		if(topKeyword!=""  && keywordChr[i].typ==CNS_COMMENT_2) {
			keywordChr[i].idtf=" ";
		}

		if(stopindent==0) {
			if( i>0
				&& keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr=="("
				&& searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i+1,1).toUpperCase()=="(") {
				// �A�����銇�ʂ̃C���f���g�}�~�B
				keywordChr[i].idtf="";
				keywordChr[i].idtb="";
				continueparcnt=continueparcnt+1;
			}else if( i>0
				&& continueparcnt>0
				&& keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr==")"
				&& searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i-1,-1).toUpperCase()==")") {
				// �A�����銇�ʂ̃C���f���g�}�~�B
				keywordChr[i].idtf="";
				keywordChr[i].idtb="";
				continueparcnt=continueparcnt-1;
			}else if( i>0
				&& keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr=="("
				&& searchSQLCommandChr(keywordChr,i+1,1).toUpperCase()=="SELECT"
				&& searchSQLCommandChr(keywordChr,i-1,-1).toUpperCase()!="SELECT") {
				indCnt=indCnt+1;
				// �K�����ŉ��s����B
				keywordChr[i].idtf="";
				keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect());
			}else if( i>0
				&& keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr==")"
				&& searchSQLCommandChr(keywordChr,i-1,-1).toUpperCase()=="SELECT"
				&& searchSQLCommandChr(keywordChr,i-1,-2).toUpperCase()!="SELECT") {
				// �C���f���g�}�~�B
				keywordChr[i].idtf="";
				keywordChr[i].idtb="";
				indCnt=indCnt-1;
			}else if( i>0
				&& keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr=="("
				&& searchSQLCommandChr(keywordChr,i+1,1).toUpperCase()=="SELECT"
				&& searchSQLCommandChr(keywordChr,i-1,-1).toUpperCase()=="SELECT") {
				indCnt=indCnt+2;
				// �K�����ŉ��s����B
				keywordChr[i].idtf="";
				keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect());
			}else if( i>0
				&& keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr==")"
				&& searchSQLCommandChr(keywordChr,i-1,-1).toUpperCase()=="SELECT"
				&& searchSQLCommandChr(keywordChr,i-1,-2).toUpperCase()=="SELECT") {
				// �C���f���g�}�~�B
				keywordChr[i].idtf="";
				keywordChr[i].idtb="";
				indCnt=indCnt-2;
			}else if( i>0
				&& keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr=="("
				&& searchSQLCommandChr(keywordChr,i+1,1).toUpperCase()!="SELECT") {
				indCnt=indCnt+1;
				// �K�����ŉ��s����B
				keywordChr[i].idtf="";
				// �J���}���s���ɔz�u���邩�ۂ���"  "�̕t�^�����肷��B
				if( getCommaPos()=="Top") {
					keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect())+"  ";
				}else {
					keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect());
				}
			}else if( i>0
				&& keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr==")"
				&& searchSQLCommandChr(keywordChr,i-1,-1).toUpperCase()!="SELECT") {
				// �C���f���g�}�~�B
				keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
				if(searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i+1,1).toUpperCase()!=";"
					&& searchSQLCommandChr(keywordChr,CNS_NORMAL,i+1,1).toUpperCase()!="") {
					keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect());
				}else {
					keywordChr[i].idtb="";
				}
				indCnt=indCnt-1;
			}
			
			// "SELECT"��̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL && keywordChr[i].chr.toUpperCase()=="SELECT") {
				// topKeyword�̐ݒ�
				if(topKeyword=="") {
					topKeyword="SELECT";
				}
				// topKeyword�ݒ���"SELECT"�́A"("�ɋ��܂�Ă��Ȃ��ꍇ�ɉ��s����B
				if(searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i-1,-1).toUpperCase()!="(" && topKeyword!="SELECT") {
					indCnt=indCnt+1;
					keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
				}
				// "SELECT"�̏o�����t���O�ɐݒ肷��B
				selectflg=i;
			}else if(selectflg>0 && judgeLineFeed(keywordChr[i])==0) {
				// "SELECT"��̒���̉��s�ʒu�́A"DISTINCT"�A"ALL"�A"UNIQUE"�A"/*+ �c */"�̌��ɂ���B
				// "SELECT"����̉��s�̈ʒu������
				keywordChr[i].idtf="";
				keywordChr[i].idtb="";
				selectflg=i;
			}else if(selectflg>0 && judgeLineFeed(keywordChr[i])==1) {
				// "SELECT"����̉��s�̈ʒu���m��
				// �J���}���s���ɔz�u���邩�ۂ���"  "�̕t�^�����肷��B
				if(getCommaPos()=="Top") {
					keywordChr[selectflg].idtb="\r\n"+makeTabSpace(indCnt+1,getTabSelect())+"  ";
				}else {
					keywordChr[selectflg].idtb="\r\n"+makeTabSpace(indCnt+1,getTabSelect());
				}
				selectflg=0;
			}

			// "CREATE"��̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL && keywordChr[i].chr.toUpperCase()=="CREATE") {
				// topKeyword�̐ݒ�
				if(topKeyword=="") {
					topKeyword="CREATE";
				}
				// "CREATE"�̏o�����t���O�ɐݒ肷��B
				createflg=i;
			}

			// "CREATE TABLE"�̏o�������o����B
			if(createflg>0
				&& keywordChr[i].chr.toUpperCase()=="TABLE") {
				createtableflg=i;
			}

			// "MERGE"��̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL && keywordChr[i].chr.toUpperCase()=="MERGE") {
				// topKeyword�̐ݒ�
				if(topKeyword=="") {
					topKeyword="MERGE";
				}
				// "MERGE"�̏o�����t���O�ɐݒ肷��B
				mergeflg=i;
			}

			// "MERGE"���"ON"�A"USING"�A"WHEN"�C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL
				&& (   keywordChr[i].chr.toUpperCase()=="ON"
					|| keywordChr[i].chr.toUpperCase()=="USING"
					|| keywordChr[i].chr.toUpperCase()=="WHEN")
				&& topKeyword=="MERGE") {
				// "ON"�̏ꍇ�́w���s+"[ON | USING | WHEN]"+���s�x
				if(mergeonusingwhenFlg==0) {
					indCnt=indCnt+1;
					mergeonusingwhenFlg=i;
				}
				keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
				keywordChr[i].idtb="";
			}
			// "MERGE"���"INSERT"�A"UPDATE"�C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL
				&& (   keywordChr[i].chr.toUpperCase()=="INSERT"
					|| keywordChr[i].chr.toUpperCase()=="UPDATE")
				&& topKeyword=="MERGE") {
				// "ON"�̏ꍇ�́w���s+"[INSERT | UPDATE]"+���s�x
				keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
				keywordChr[i].idtb="";
			}

			// "INSERT"��̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL && keywordChr[i].chr.toUpperCase()=="INSERT") {
				// topKeyword�̐ݒ�
				if(topKeyword=="") {
					topKeyword="INSERT";
				}
				// "INSERT"�̏o�����t���O�ɐݒ肷��B
				insertflg=i;
			}
			// "INSERT"��o�����"VALUES"��̃C���f���g�ݒ�
			if( insertflg>0
				&& keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr.toUpperCase()=="VALUES") {
				// "VALUES"�̏ꍇ�́w���s+"VALUES"�x
				keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt+1,getTabSelect());
				keywordChr[i].idtb="";
			}
			// "INSERT"��o�����"INTO"��̃C���f���g�ݒ�
			if( insertflg>0
				&& keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr.toUpperCase()=="INTO") {
				// "VALUES"�̏ꍇ�́w���s+"INTO"�x
				keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt+1,getTabSelect());
				keywordChr[i].idtb="";
			}

			// "FROM"��̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL && keywordChr[i].chr.toUpperCase()=="FROM") {
				// "SELECT"��"FROM"�̏ꍇ�́w���s+"FROM"+���s�x
				if(searchSQLCommandChr(keywordChr,i-1,-1).toUpperCase()=="SELECT") {
					keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
					// �J���}���s���ɔz�u���邩�ۂ���"  "�̕t�^�����肷��B
					if(getCommaPos()=="Top") {
						keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt+1,getTabSelect())+"  ";
					}else {
						keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt+1,getTabSelect());
					}
				}else {
					// ��L��������ɍ���Ȃ�"FROM"�̏ꍇ�̓m�[�C���f���g
					keywordChr[i].idtf="";
					keywordChr[i].idtb="";
				}
			}

			// "UPDATE"����"SET"��̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr.toUpperCase()=="SET"
				&& searchSQLCommandChr(keywordChr,i-1,-1).toUpperCase()=="UPDATE") {
				// "UPDATE"����"SET"��̏ꍇ�́w���s+"SET"+���s�x
					keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
					// �J���}���s���ɔz�u���邩�ۂ���"  "�̕t�^�����肷��B
					if(getCommaPos()=="Top") {
						keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt+1,getTabSelect())+"  ";
					}else {
						keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt+1,getTabSelect());
					}
			}

			// "WHERE"��̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL && keywordChr[i].chr.toUpperCase()=="WHERE") {
				// "WHERE"�̏ꍇ�́w���s+"WHERE"+���s�x
				keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
				// WHERE��́uAND�v�A�uOR�v���s���ɔz�u���邩�ۂ��ŃC���f���g�̗L�������肷��B
				if(getAndPos()=="Top") {
					keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt+1,getTabSelect());
				}else {
					keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect());
				}
			}

			// �W�����Z�q"UNION"�̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL && keywordChr[i].chr.toUpperCase()=="UNION") {
				// "UNION"�̏ꍇ�́w���s+"UNION"+���s�x
				keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
				// "UNION"�̒����"ALL"�����݂��Ă��Ȃ������ׂ�B
				if(searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i+1,1).toUpperCase()=="ALL") {
					unionallflg=i;
				}else {
					keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect());
				}
			}else if (unionallflg>0
						&& keywordChr[i].typ==CNS_NORMAL
						&& keywordChr[i].chr.toUpperCase()=="ALL") {
				// "UNION ALL"�̌��ŉ��s����B
				keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect());
			}
			// �W�����Z�q"MINUS"�A"INTERSECT"�̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL
				&& (
						keywordChr[i].chr.toUpperCase()=="MINUS"
					||  keywordChr[i].chr.toUpperCase()=="INTERSECT")) {
				// "UNION"�̏ꍇ�́w���s+"MINUS | INTERSECT"+���s�x
				keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
				keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect());
			}

			// "CREATE TABLE"�̃C���f���g�ݒ�
			if(createtableflg>0
				&& keywordChr[i].typ==CNS_NORMAL
				&& topKeyword=="CREATE"
				&& checkCreateTableKey(keywordChr[i].chr.toUpperCase())==1) {
				// "CREATE TABLE"���s�L�[���[�h�̏ꍇ�́w���s+�L�[���[�h�x
				keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
				keywordChr[i].idtb="";
			}

			// "ORDER BY"�A"GROUP BY"��̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL
				&& (    keywordChr[i].chr.toUpperCase()=="ORDER"
					||  keywordChr[i].chr.toUpperCase()=="GROUP")
				&& searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i+1,1).toUpperCase()=="BY") {
				// "ORDER"�A"GROUP"�̏ꍇ�́w���s+"ORDER | GROUP"�x
				keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
			}else if(keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr.toUpperCase()=="BY"
				&& (
						searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i-1,-1).toUpperCase()=="ORDER"
					||  searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i-1,-1).toUpperCase()=="GROUP")) {
				// �J���}���s���ɔz�u���邩�ۂ���"  "�̕t�^�����肷��B
				if(getCommaPos()=="Top") {
					keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt+1,getTabSelect())+"  ";
				}else {
					keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt+1,getTabSelect());
				}
			}
			// "HAVING"��̂̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL && keywordChr[i].chr.toUpperCase()=="HAVING") {
				// "HAVING"�̏ꍇ�́w���s+"HAVING"�x
				keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
				keywordChr[i].idtb="";
			}

			// "RETURNING"��̂̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL && keywordChr[i].chr.toUpperCase()=="RETURNING") {
				// "RETURNING"�̏ꍇ�́w���s+"RETURNING"�x
				keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
				keywordChr[i].idtb="";
			}

			// "AND"�A"OR"��̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL
				&& (
						keywordChr[i].chr.toUpperCase()=="AND"
					||  keywordChr[i].chr.toUpperCase()=="OR")) {
				// "BETWEEN"��̏o���𒲂ׂ�B
				if(keywordChr[i].chr.toUpperCase()=="AND" && betweenflg>0) {
					// "BETWEEN"�咼��̓C���f���g���Ȃ��B
				}else {
					// WHERE��́uAND�v�A�uOR�v���s���ɔz�u���邩�ۂ���"    "�̕t�^�����肷��B
					if(getAndPos()=="Top") {
						keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
						// "OR"��"AND"���ꕶ�����Ȃ��̂�" "��₤�B
						if(keywordChr[i].chr.toUpperCase()=="OR") {
							keywordChr[i].idtb="  ";
						}else {
							keywordChr[i].idtb="";
						}
					}else {
						keywordChr[i].idtf="";
						keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect());
					}
				}
				betweenflg=0;
			}

			// "INCLUDING"��̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr.toUpperCase()=="INCLUDING") {
				if(getAndPos()=="Top") {
					keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
					keywordChr[i].idtb="";
				}else {
					keywordChr[i].idtf="";
					keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect());
				}
			}

			// "CASCADE"��̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL
				&& keywordChr[i].chr.toUpperCase()=="CASCADE") {
				if(getAndPos()=="Top") {
					keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
					keywordChr[i].idtb="";
				}else {
					keywordChr[i].idtf="";
					keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect());
				}
			}

			// "BETWEEN"��̌��o
			if(keywordChr[i].typ==CNS_NORMAL && keywordChr[i].chr.toUpperCase()=="BETWEEN") {
				// "BETWEEN"�̏ꍇ�͎��ɑ���"AND"���m�[�C���f���g�ɂ���׃t���O��ݒ肷��B
				betweenflg=i;
			}

			// "JOIN"��̌��o
			if(keywordChr[i].typ==CNS_NORMAL && keywordChr[i].chr.toUpperCase()=="JOIN") {
				// SQL:1999�\���̈ꕔ��"JOIN"�̏o�������o����׃t���O��ݒ肷��B
				joinflg=i;
			}

			// ","��̃C���f���g�ݒ�
			if(keywordChr[i].typ==CNS_NORMAL && keywordChr[i].chr.toUpperCase()==",") {
				// �J���}���s���ɔz�u���邩�ۂ��ŉ��s�̈ʒu�����肷��B
				if(getCommaPos()=="Top") {
					if(searchSQLCommandChr(keywordChr,i-1,-1).toUpperCase()=="SELECT") {
						keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt+1,getTabSelect());
						keywordChr[i].idtb=" ";
					}else if(searchSQLCommandChr(keywordChr,i-1,-1).toUpperCase()=="UPDATE") {
						keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt+1,getTabSelect());
						keywordChr[i].idtb=" ";
					}else {
						keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
						keywordChr[i].idtb=" ";
					}
				}else {
					if(searchSQLCommandChr(keywordChr,i-1,-1).toUpperCase()=="SELECT") {
						keywordChr[i].idtf=" ";
						keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt+1,getTabSelect());
					}else if(searchSQLCommandChr(keywordChr,i-1,-1).toUpperCase()=="UPDATE") {
						keywordChr[i].idtf=" ";
						keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt+1,getTabSelect());
					}else {
						keywordChr[i].idtf=" ";
						keywordChr[i].idtb="\r\n"+makeTabSpace(indCnt,getTabSelect());
					}
				}
			}
		}

		// �V�[�P���X�I�u�W�F�N�g�p
		if(keywordChr[i].chr.toUpperCase()=="SEQUENCE") {
			sequenceflg=i;
		}else if(sequenceflg>0 && checkSequenceKey(keywordChr[i].chr.toUpperCase())==1) {
			keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
		}

		// "CREATE USER"�p
		if(createflg>0 && keywordChr[i].chr.toUpperCase()=="USER") {
			createuserflg=i;
		}else if(createuserflg>0 && checkUserKey(keywordChr[i].chr.toUpperCase())==1) {
			keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt,getTabSelect());
		}

		// ====== �C���f���g�}�~��� ======
		if(stopindent==0
			&& searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i+1,1).toUpperCase()=="("
			&& searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i+1,2).toUpperCase()=="+"
			&& searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i+1,3).toUpperCase()==")") {
			// �O��������"(+)"�����o�����ꍇ�́A"("�̏o���ŃC���f���g��Ƃ��Ȃ��悤�ɐ��䂷��B
			stopindent=parCnt+1;
		}else if(stopindent==0
			&& keywordChr[i].chr.toUpperCase()=="IN"
			&& searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i+1,1).toUpperCase()=="("
			&& searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i+1,2).toUpperCase()!="SELECT") {
			// IN���Z�q�����"("�����⍇���̊J�n��\��"("�ł͂Ȃ��ꍇ�C���f���g��Ɨ}�~����B
			stopindent=parCnt+1;
		}else if(oracleRw[keywordChr[i].chr.toUpperCase()]!=undefined
			&& stopindent==0
			&& i<keywordLength
			&& searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i+1,1).toUpperCase()=="(") {
			// �\���̌���"("�������ꍇ�����o����B
			// �C���f���g�}�~���s���Ă��Ȃ��Ȃ���΃C���f���g�}�~����B
			stopindent=parCnt+1;
		}else if(mergeflg>0
			&& stopindent==0
			&& i<keywordLength
			&& (keywordChr[i].chr.toUpperCase()=="ON")) {
			// MERGE��"ON"�̃C���f���g�}�~�J�n�B
			stopindent=parCnt+1;
		}else if(joinflg>0
			&& stopindent==0
			&& i<keywordLength
			&& (keywordChr[i].chr.toUpperCase()=="ON" || keywordChr[i].chr.toUpperCase()=="USING")) {
			keywordChr[i].idtf="\r\n"+makeTabSpace(indCnt+2,getTabSelect());
			keywordChr[i].idtb="";
			if( searchSQLKeyWordChr(keywordChr,CNS_NORMAL,i+1,1).toUpperCase()=="(") {
				// SQL:1999�\����"ON"�A"USING"��̃C���f���g�}�~�J�n�B
				joinflg=0;
				stopindent=parCnt+1;
			}
		}else if(keywordChr[i].chr==")" && stopindent>parCnt) {
			// �C���f���g�}�~�����́Astopindent��parCnt��菬�����Ȃ����ꍇ
			stopindent=0;
		}
	}
	var rrr;
	rrr="";
	for (var n=1;n<=keywordLength;n++) {
		// �C���f���g�ɂ��A�����s���揜���B
		if(n<keywordLength
			&& substrRight(keywordChr[n].idtb,2).replace(" ","")=="\r\n"
			&& substrLeft(keywordChr[n+1].idtf,2).replace(" ","")=="\r\n"){
			keywordChr[n].idtb="";
		}
		// �L�[���[�h���C���f���g�Ȃ��ŘA�����悤�Ƃ��Ă���ꍇ��}�~�B
		if(n<keywordLength && keywordChr[n].idtb=="" && keywordChr[n+1].idtf==""){
			 keywordChr[n].idtb=" ";
		}
		rrr=rrr+keywordChr[n].idtf+keywordChr[n].chr+keywordChr[n].idtb;
		// �f�o�b�O�I
		//rrr=rrr+"["+n+"]"+keywordChr[n].idtf+keywordChr[n].chr+keywordChr[n].idtb+"\r\n";
	}
	
	return rrr;
}

/*
 * Oracle��SQL�\����z��ɍ쐬
 */
function get_oracleRw() {
	// �߂�l�Ƃ���A�z�z���錾����B
	var oracleRw = new Array();

	// Oracle�̗\����A�z�z��ɍ쐬����B
	oracleRw["ABS"]="1";
	oracleRw["SIGN"]="2";
	oracleRw["MOD"]="3";
	oracleRw["ROUND"]="4";
	oracleRw["TRUNC"]="5";
	oracleRw["FLOOR"]="6";
	oracleRw["CEIL"]="7";
	oracleRw["SQRT"]="8";
	oracleRw["POWER"]="9";
	oracleRw["EXP"]="10";
	oracleRw["LN"]="11";
	oracleRw["LOG"]="12";
	oracleRw["SIN"]="13";
	oracleRw["COS"]="14";
	oracleRw["TAN"]="15";
	oracleRw["SINH"]="16";
	oracleRw["COSH"]="17";
	oracleRw["TANH"]="18";
	oracleRw["ASIN"]="19";
	oracleRw["ACOS"]="20";
	oracleRw["ATAN"]="21";
	oracleRw["ATAN2"]="22";
	oracleRw["BITAND"]="23";
	oracleRw["WIDTH_BUCKET"]="24";
	oracleRw["NANVL"]="25";
	oracleRw["REMAINDER"]="26";
	oracleRw["ASCII"]="27";
	oracleRw["CHR"]="28";
	oracleRw["NCHR"]="29";
	oracleRw["CONCAT"]="30";
	oracleRw["REPLACE"]="31";
	oracleRw["LPAD"]="32";
	oracleRw["RPAD"]="33";
	oracleRw["LTRIM"]="34";
	oracleRw["RTRIM"]="35";
	oracleRw["TRIM"]="36";
	oracleRw["REPLCAE"]="37";
	oracleRw["INSTR"]="38";
	oracleRw["INSTRB"]="39";
	oracleRw["LENGTH"]="40";
	oracleRw["LENGTHB"]="41";
	oracleRw["INITCAP"]="42";
	oracleRw["LOWER"]="43";
	oracleRw["UPPER"]="44";
	oracleRw["NLS_INITCAP"]="45";
	oracleRw["NLS_LOWER"]="46";
	oracleRw["NLS_UPPER"]="47";
	oracleRw["NLSSORT"]="48";
	oracleRw["SOUNDEX"]="49";
	oracleRw["SUBSTR"]="50";
	oracleRw["SUBSTRB"]="51";
	oracleRw["TRANSLATE"]="52";
	oracleRw["TREAT"]="53";
	oracleRw["REGEXP_INSTR"]="54";
	oracleRw["REGEXP_SUBSTR"]="55";
	oracleRw["REGEXP_REPLACE"]="56";
	oracleRw["SYSDATE"]="57";
	oracleRw["CURRENT_DATE"]="58";
	oracleRw["LOCALTIMESTAMP"]="59";
	oracleRw["CURRENT_TIMESTAMP"]="60";
	oracleRw["SYSTIMESTAMP"]="61";
	oracleRw["DBTIMEZONE"]="62";
	oracleRw["SESSIONTIMEZONE"]="63";
	oracleRw["FROM_TZ"]="64";
	oracleRw["TZ_OFFSET"]="65";
	oracleRw["NEXT_DAY"]="66";
	oracleRw["ADD_MONTHS"]="67";
	oracleRw["LAST_DAY"]="68";
	oracleRw["MONTHS_BETWEEN"]="69";
	oracleRw["NEW_TIME"]="70";
	oracleRw["TO_TIMESTAMP"]="71";
	oracleRw["TO_TIMESTAMP_TZ"]="72";
	oracleRw["EXTRACT"]="73";
	oracleRw["SYS_EXTRACT_UTC"]="74";
	oracleRw["NUMTODSINTERVAL"]="75";
	oracleRw["TO_DSINTERVAL"]="76";
	oracleRw["NUMTOYMINTERVAL"]="77";
	oracleRw["TO_YMINTERVAL"]="78";
	oracleRw["ASCIISTR"]="79";
	oracleRw["BIN_TO_NUM"]="80";
	oracleRw["CHARTOROWID"]="81";
	oracleRw["ROWIDTOCHAR"]="82";
	oracleRw["ROWIDTONCHAR"]="83";
	oracleRw["COMPOSE"]="84";
	oracleRw["DECOMPOSE"]="85";
	oracleRw["UNISTR"]="86";
	oracleRw["CONVERT"]="87";
	oracleRw["HEXTORAW"]="88";
	oracleRw["RAWTOHEX"]="89";
	oracleRw["RAWTONHEX"]="90";
	oracleRw["TO_DATE"]="91";
	oracleRw["TO_LOB"]="92";
	oracleRw["TO_CLOB"]="93";
	oracleRw["TO_NCLOB"]="94";
	oracleRw["TO_NUMBER"]="95";
	oracleRw["TO_MULTI_BYTE"]="96";
	oracleRw["TO_SINGLE_BYTE"]="97";
	oracleRw["CAST"]="98";
	oracleRw["SCN_TO_TIMESTAMP"]="99";
	oracleRw["TIMESTAMP_TO_SCN"]="100";
	oracleRw["TO_BINARY_FLOAT"]="101";
	oracleRw["TO_BINARY_DOUBLE"]="102";
	oracleRw["BFILENAME"]="103";
	oracleRw["COALESCE"]="104";
	oracleRw["DECODE"]="105";
	oracleRw["PATH"]="106";
	oracleRw["DEPTH"]="107";
	oracleRw["DUMP"]="108";
	oracleRw["EMPTY_BLOB"]="109";
	oracleRw["EMPTY_CLOB"]="110";
	oracleRw["EXISTSNODE"]="111";
	oracleRw["EXTRACTVALUE"]="112";
	oracleRw["GREATEST"]="113";
	oracleRw["LEAST"]="114";
	oracleRw["NLS_CHARSET_DECL_LEN"]="115";
	oracleRw["NLS_CHARSET_ID"]="116";
	oracleRw["NLS_CHARSET_NAME"]="117";
	oracleRw["NULLIF"]="118";
	oracleRw["NVL"]="119";
	oracleRw["NVL2"]="120";
	oracleRw["SYS_CONNECT_BY_PATH"]="121";
	oracleRw["SYS_CONTEXT"]="122";
	oracleRw["SYS_DBURIGEN"]="123";
	oracleRw["SYS_GUID"]="124";
	oracleRw["SYS_TYPEID"]="125";
	oracleRw["SYS_XMLAGG"]="126";
	oracleRw["SYS_XMLGEN"]="127";
	oracleRw["UID"]="128";
	oracleRw["UPDATEXML"]="129";
	oracleRw["USER"]="130";
	oracleRw["USERENV"]="131";
	oracleRw["VSIZE"]="132";
	oracleRw["XMLELEMENT"]="133";
	oracleRw["XMLCOLATTVAL"]="134";
	oracleRw["XMLCONCAT"]="135";
	oracleRw["XMLFOREST"]="136";
	oracleRw["XMLSEQUENCE"]="137";
	oracleRw["XMLTRANSFORM"]="138";
	oracleRw["LNNVL"]="139";
	oracleRw["ORA_HASH"]="140";
	oracleRw["AVG"]="141";
	oracleRw["COUNT"]="142";
	oracleRw["MAX"]="143";
	oracleRw["MIN"]="144";
	oracleRw["SUM"]="145";
	oracleRw["STDDEV"]="146";
	oracleRw["STDDEV_POP"]="147";
	oracleRw["STDDEV_SAMP"]="148";
	oracleRw["VARIANCE"]="149";
	oracleRw["VAR_POP"]="150";
	oracleRw["VAR_SAMP"]="151";
	oracleRw["COVAR_POP"]="152";
	oracleRw["COVAR_SAMP"]="153";
	oracleRw["CORR"]="154";
	oracleRw["CUME_DIST"]="155";
	oracleRw["RANK"]="156";
	oracleRw["DENSE_RANK"]="157";
	oracleRw["FIRST"]="158";
	oracleRw["LAST"]="159";
	oracleRw["GROUP_ID"]="160";
	oracleRw["GROUPING"]="161";
	oracleRw["GROUPING_ID"]="162";
	oracleRw["PERCENT_RANK"]="163";
	oracleRw["PERCENTILE_CONT"]="164";
	oracleRw["PERCENTILE_DISC"]="165";
	oracleRw["REGR_SLOPE"]="166";
	oracleRw["REGR_INTERCEPT"]="167";
	oracleRw["REGR_COUNT"]="168";
	oracleRw["REGR_R2"]="169";
	oracleRw["REGR_AVGX"]="170";
	oracleRw["REGR_AVGY"]="171";
	oracleRw["REGR_SXX"]="172";
	oracleRw["REGR_SYY"]="173";
	oracleRw["REGR_SXY"]="174";
	oracleRw["CORR_S"]="175";
	oracleRw["CORR_K"]="176";
	oracleRw["MEDIAN"]="177";
	oracleRw["STATS_BINOMIAL_TEST"]="178";
	oracleRw["STATS_CROSSTAB"]="179";
	oracleRw["STATS_F_TEST"]="180";
	oracleRw["STATS_KS_TEST"]="181";
	oracleRw["STATS_MODE"]="182";
	oracleRw["STATS_MW_TEST"]="183";
	oracleRw["STATS_ONE_WAY_ANOVA"]="184";
	oracleRw["STATS_T_TEST_ONE"]="185";
	oracleRw["STATS_T_TEST_PAIRED"]="186";
	oracleRw["STATS_T_TEST_INDEP"]="187";
	oracleRw["STATS_T_TEST_INDEPU"]="188";
	oracleRw["STATS_WSR_TEST"]="189";
	oracleRw["FIRST_VALUE"]="190";
	oracleRw["LAST_VALUE"]="191";
	oracleRw["LAG"]="192";
	oracleRw["LEAD"]="193";
	oracleRw["NTILE"]="194";
	oracleRw["RATIO_TO_REPORT"]="195";
	oracleRw["REGR_AVRX"]="196";
	oracleRw["ROW_NUMBER"]="197";
	oracleRw["REF"]="198";
//	oracleRw["VALUE"]="199";
	oracleRw["DEREF"]="200";
	oracleRw["REFTOHEX"]="201";
	oracleRw["MAKE_REF"]="202";
	oracleRw["CARDINALITY"]="203";
	oracleRw["COLLECT"]="204";
	oracleRw["POWERMULTISET"]="205";
	oracleRw["POWERMULTISET_BY_CARDINALITY"]="206";
//	oracleRw["SET"]="207";
	oracleRw["CV"]="208";
	oracleRw["ITERATION_NUMBER"]="209";
	oracleRw["PRESENTNNV"]="210";
	oracleRw["PRESENTV"]="211";
	oracleRw["PREVIOUS"]="212";
	oracleRw["OVER"]="213";
//	oracleRw["IN"]="214";
//	oracleRw["ANY"]="215";
//	oracleRw["SOME"]="216";
//	oracleRw["EXISTS"]="217";
	oracleRw["LIKE"]="218";
	oracleRw["VALUE"]="219";
//	oracleRw["INTO"]="220";
	oracleRw["TO_CHAR"]="221";
	oracleRw["TABLE"]="222";
	oracleRw["WITHIN"]="223";
	oracleRw["NOT"]="224";
	oracleRw["CUBE"]="225";
	oracleRw["AND"]="226";
	oracleRw["OR"]="227";

	// �f�[�^�^
	oracleRw["VARCHAR2"]="1";
	oracleRw["NVARCHAR2"]="1";
	oracleRw["NUMBER"]="1";
	oracleRw["LONG"]="1";
	oracleRw["DATE"]="1";
	oracleRw["BINARY_FLOAT"]="1";
	oracleRw["BINARY_DOUBLE"]="1";
	oracleRw["TIMESTAMP"]="1";
	oracleRw["INTERVAL"]="1";
	oracleRw["YEAR"]="1";
	oracleRw["MONTH"]="1";
	oracleRw["DAY"]="1";
	oracleRw["SECOND"]="1";
	oracleRw["RAW"]="1";
	oracleRw["ROWID"]="1";
	oracleRw["UROWID"]="1";
	oracleRw["CHAR"]="1";
	oracleRw["NCHAR"]="1";
	oracleRw["CLOB"]="1";
	oracleRw["NCLOB"]="1";
	oracleRw["BLOB"]="1";
	oracleRw["LOB"]="1";
	oracleRw["BFILE"]="1";

	oracleRw["KEY"]="2";
	oracleRw["CHECK"]="2";
	oracleRw["UNIQUE"]="2";
	oracleRw["CONSTRAINT"]="2";
	oracleRw["STORAGE"]="2";

	// �A�z�z����ďo�����ɖ߂��B
	return oracleRw;
}

/*
 * �V���v���Ȑ܂肽���݃��j���[���쐬
 */
allOpend=false;
function foldingMenu(obj)
{
	if(!obj.id || obj.id.indexOf("li")!=0)
	{
		return false;
	}
	if(obj.id=="allopenbutton")
	{
		allOpen();
		return false;
	}

	obj2="u"+obj.id;

	if(document.all)
	{
		if(!document.all(obj2))
		{
			return false;
		}
		obj2=document.all(obj2);
		obj2.className=obj2.className=="open" ? "close":"open";
		obj.className=obj2.className;
	}
	else if(document.getElementById)
	{
		if(!document.getElementById(obj2))
		{
			return false;
		}
		obj2=document.getElementById(obj2);
		obj2.className=obj2.className=="open" ? "close":"open";
		obj.className=obj2.className;
	}
}
