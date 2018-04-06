classdef Collection < handle
%Class that generates Collection Object to store and manipulate other Objects
    properties (Access = private)
        Map = containers.Map;
        Count = 0;
        Name = 'New Collection';
    end
    %% Constructor
    methods
        function obj = Collection(str)
            if nargin > 0
                obj.Name = str;
            end
        end
    end
    %% Other functions
    methods
        function add(obj, newObj, key)
            %function that adds the object to Collection Array and
            %returns true or false
            if nargin > 0
                if nargin < 3
                    key = num2str(obj.Count);
                end
                % The Collection Array contains a structure object with
                % the 2 fields Object and Key, where Object contains the
                % Object supposed to be added and key is a String that
                % allows to search the Collection for this specific Object
                % later on
                obj.Map(key) = newObj;
                obj.Count = obj.Count + 1;
            else
                error('')
            end
        end
        %%
        function remove(obj, index)
            % function that removes the Object/Element at index by
            % replacing the Collection Array with new Array without indexed
            % Element
            if nargin > 0
                arCopy = obj.arCol;
                %Reset the Collection Array to 1 Element (here first Element from last Array)
                obj.arCol = arCopy(1);
                %Preallocate memory with random Element (here first Array Element)
                %Now the Array Element length is minus 1
                obj.arCol(obj.colSize - 1) = arCopy(1);
                if index == 1
                    obj.arCol = arCopy(2:obj.colSize);
                elseif index == obj.colSize
                    obj.arCol = arCopy(1:(obj.colSize-1));
                else
                    obj.arCol(1:(index-1)) = arCopy(1:(index-1));
                    obj.arCol(index:obj.colSize-1) = arCopy((index+1):obj.colSize);
                end
                %Set new Array Size
                obj.colSize = obj.colSize - 1;
            else
                error('');
            end
        end
        %%
        function o = item(obj, index)
            % function that returns the Object stored in Collection at given
            % index, if error occurs or index is greater than Size of
            % Collection logical 0 is returned else the object is returned
                if nargin > 0
                    if index > obj.colSize
                        o = [];
                        error('');
                    else
                        %Retrieve the Object from Structure Element in Collection Array
                        structure = obj.arCol(index);
                        o = structure.Object;
                    end
                else
                    o = [];
                    error('');
                end
        end
        
       function c = getCount(obj)
            c = obj.Count;
        end
        
        function n = getName(obj)
            n = obj.Name;
        end
    end
end