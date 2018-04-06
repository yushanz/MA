classdef Record < handle
    % RECORD class definition for object that represents a measure file on local filesystem
    properties
        Name = '';
        Date = [];
        Time = [];
        Units = ''
        Description = '';
        SampleRate = 0;
        CycleCount = 0;
        Data = [];
    end
    % Constructor
    methods
        function obj = Record(name,date,time,units,samplerate,cyclecount,data)
            if nargin > 0  
            obj.Name = name;
            obj.Date = date;
            obj.Time = time;
            obj.Units = units;
            obj.SampleRate = samplerate;
            obj.CycleCount = cyclecount;
            obj.Data = data;
            end
        end %Record
        
    end
    methods(Static)
        
    end
end