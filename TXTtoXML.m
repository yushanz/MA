filename = 'TXTfiles'; % create XML file

docNode = com.mathworks.xml.XMLUtils.createDocument('TXTfiles'); % create document node and root element
docRootNode= docNode.getDocumentElement(); %identify root element
% TXTfiles = docNode.getDocumentElement();
docRootNode.setAttribute('version','1.0'); %set version attribute

FileNode = docNode.createElement('File'); %create File Node under TXTfiles
docRootNode.appendChild(FileNode);
    
    DatumNode = docNode.createElement('Datum'); %create Datum Node under File, Y/M/D Nodes under Datum
    FileNode.appendChild(DatumNode);
        YearNode = docNode.createElement('Year');
        YearNode.appendChild(docNode.createTextNode(sprintf('%i',2017)));
        DatumNode.appendChild(YearNode);
        
        MonthNode = docNode.createElement('Month');
        MonthNode.appendChild(docNode.createTextNode(sprintf('%i',10)));
        DatumNode.appendChild(MonthNode);
        
        DateNode = docNode.createElement('Date');
        DateNode.appendChild(docNode.createTextNode(sprintf('%i',19)));
        DatumNode.appendChild(DateNode);
        
    TimeNode = docNode.createElement('Time'); %create Time Node under File, H/M/S under Time
    FileNode.appendChild(TimeNode);
        HourNode = docNode.createElement('Hour');
        HourNode.appendChild(docNode.createTextNode(sprintf('%i',11)));
        TimeNode.appendChild(HourNode);
        
        MinNode = docNode.createElement('Min');
        MinNode.appendChild(docNode.createTextNode(sprintf('%i',38)));
        TimeNode.appendChild(MinNode);
        
        SecondNode = docNode.createElement('Second');
        SecondNode.appendChild(docNode.createTextNode(sprintf('%i',54)));
        TimeNode.appendChild(SecondNode);
    
    CCNode = docNode.createElement('CycleCount'); %create CycleCount Node under File 
    %CCNode.setAttribute('CycleCount');
    CCNode.appendChild(docNode.createTextNode(sprintf('%i', 3643)));
    FileNode.appendChild(CCNode);

    LabelNode = docNode.createElement('Label'); %create Label Node under File 
    LabelNode.appendChild(docNode.createTextNode(sprintf('timestamp1; position; timestamp2; velocity; timestamp3; current;')));
    FileNode.appendChild(LabelNode);
    
    DataNode = docNode.createElement('Data'); %create Data Node under File 
    DataNode.appendChild(docNode.createTextNode(sprintf('n*6 matrix')));
    FileNode.appendChild(DataNode);
    
xmlFileName = [filename, '.xml'];
xmlwrite(xmlFileName,docNode);
type(xmlFileName);
