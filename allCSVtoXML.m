%csv to xml
cd ('F:\DOCUMENTS\MA'); %set folder

filename = 'CSVfiles'; % create XML file
docNode = com.mathworks.xml.XMLUtils.createDocument('CSVfiles'); % create document node and root element
docRootNode= docNode.getDocumentElement(); %identify root element

csvlist = dir('*.csv');

for i = 1 : length(csvlist)
    csvfile = csvlist(i).name; %(1:length(csvlist(i).name)) 
    [path,name,ext] = fileparts(csvfile);
    
    S = regexp(name, '_','split'); % cell2mat(S(1));
    cyclecount = S{2};
    sensorname = S{3};
    ipaddress = S{4};
    port = S{5};
    datum = S{6};
    time = S{7};
    
    yy = datum(1:4);
    mm = datum(6:7);
    dd = datum(9:10);
    hh = time(1:2);
    mnt = time(4:5);
    ss = time(7:8);
    
    fileID=fopen(csvfile);
    firstline = textscan(fileID,'%s',1); %get the first line of csv file, in order to get SampleRate
    fclose(fileID);
    number = textscan(cell2mat(firstline{1}),'%*q %f', 'Delimiter',';'); %get the data from first line of csv file
    samplerate = cell2mat(number);
    
    data = csvread(csvfile,2,0); %import from data files
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
    
    SensorNameNode = docNode.createElement('SensorName'); %create SensorName Node under File 
    SensorNameNode.appendChild(docNode.createTextNode(sprintf(sensorname)));
    FileNode.appendChild(SensorNameNode);    
    
    SampleRateNode = docNode.createElement('SampleRate'); %create SampleRate Node under File 
    SampleRateNode.appendChild(docNode.createTextNode(sprintf('%d',samplerate)));
    FileNode.appendChild(SampleRateNode); 
    
    IPNode = docNode.createElement('IPaddress'); %create IP Node under File 
    IPNode.appendChild(docNode.createTextNode(sprintf(ipaddress)));
    FileNode.appendChild(IPNode);      
    
    PortNode = docNode.createElement('Port'); %create Port Node under File 
    PortNode.appendChild(docNode.createTextNode(sprintf(port)));
    FileNode.appendChild(PortNode);  

    UnitsNode = docNode.createElement('Units'); %create Units Node under File 
    UnitsNode.appendChild(docNode.createTextNode(sprintf('mA')));
    FileNode.appendChild(UnitsNode);
    
    DataNode = docNode.createElement('Data'); %create Data Node under File 
    DataNode.appendChild(docNode.createTextNode(sprintf('%d x %d matrix', size1, size2)));
    FileNode.appendChild(DataNode);
    
end
    
xmlFileName = [filename, '.xml'];
xmlwrite(xmlFileName,docNode);
type(xmlFileName);

