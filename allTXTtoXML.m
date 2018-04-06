%txt to xml
cd ('F:\DOCUMENTS\MA'); %set folder

filename = 'TXTfiles'; % create XML file
docNode = com.mathworks.xml.XMLUtils.createDocument('TXTfiles'); % create document node and root element
docRootNode= docNode.getDocumentElement(); %identify root element

txtlist = dir('*.txt'); %is struct %dir .txt; %all txt files in current folder

for i = 1 : length(txtlist)
    txtfile = txtlist(i).name; %(1:length(txtlist(i).name)) 
    [path,name,ext] = fileparts(txtfile);
    
    underline = strfind(name, '_'); %underline is double 
    %S = regexp(name, '_','split'); cell2mat(S(1))
    datum = name(1:(underline(1)-1)); %char
    time = name((underline(1)+1):(underline(2)-1)); %char
    cyclecount = name((underline(2)+1):(underline(3)-1)); %char
    
    yy = datum(1:4);
    mm = datum(5:6);
    dd = datum(7:8);
    hh = time(1:2);
    mnt = time(3:4);
    ss = time(5:6);
    
    data = importdata(txtfile); %import from data files
    [size1, size2] = size(data);
    
    FileNode = docNode.createElement('File'); %create File Node under TXTfiles
    docRootNode.appendChild(FileNode);
    
    DatumNode = docNode.createElement('Datum'); %create Datum Node under File, Y/M/D Nodes under Datum
    FileNode.appendChild(DatumNode);
        YearNode = docNode.createElement('Year');
        YearNode.appendChild(docNode.createTextNode(sprintf(yy)));
        DatumNode.appendChild(YearNode);
        
        MonthNode = docNode.createElement('Month');
        MonthNode.appendChild(docNode.createTextNode(sprintf(mm)));
        DatumNode.appendChild(MonthNode);
        
        DateNode = docNode.createElement('Date');
        DateNode.appendChild(docNode.createTextNode(sprintf(dd)));
        DatumNode.appendChild(DateNode);
        
    TimeNode = docNode.createElement('Time'); %create Time Node under File, H/M/S under Time
    FileNode.appendChild(TimeNode);
        HourNode = docNode.createElement('Hour');
        HourNode.appendChild(docNode.createTextNode(sprintf(hh)));
        TimeNode.appendChild(HourNode);
        
        MinNode = docNode.createElement('Min');
        MinNode.appendChild(docNode.createTextNode(sprintf(mnt)));
        TimeNode.appendChild(MinNode);
        
        SecondNode = docNode.createElement('Second');
        SecondNode.appendChild(docNode.createTextNode(sprintf(ss)));
        TimeNode.appendChild(SecondNode);
    
    CCNode = docNode.createElement('CycleCount'); %create CycleCount Node under File 
    %CCNode.setAttribute('CycleCount');
    CCNode.appendChild(docNode.createTextNode(sprintf(cyclecount)));
    FileNode.appendChild(CCNode);

    LabelNode = docNode.createElement('Label'); %create Label Node under File 
    LabelNode.appendChild(docNode.createTextNode(sprintf('timestamp1; position; timestamp2; velocity; timestamp3; current;')));
    FileNode.appendChild(LabelNode);
    
    DataNode = docNode.createElement('Data'); %create Data Node under File 
    DataNode.appendChild(docNode.createTextNode(sprintf('%d x %d matrix', size1, size2)));
    FileNode.appendChild(DataNode);
    
end
    
xmlFileName = [filename, '.xml'];
xmlwrite(xmlFileName,docNode);
type(xmlFileName);

