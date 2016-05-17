classdef Led

    properties
        name; % Name of the led, used for plots
        spd; % Spectral power distribution from 380nm to 780nm at 5nm
        cct; % Correlated color temperature
        lumens; % Luminous flux
        ler; % Luminous efficacy of radiation for the spd
        power; % Radiation power
        maxCoeff; % Maximum coefficient used in the mixing
    end
    
    methods
        function this = Led( name, spd, lumens, maxCoeff )
            this.name = name;
            this.spd = spd;
            this.lumens = lumens;
            this.ler = spdToLER(spd);
            this.power = this.lumens / this.ler;
            this.cct = spdToCct(spd);
            if exist('maxCoeff', 'var')
                this.maxCoeff = maxCoeff;
            else
                this.maxCoeff = 1;
            end
        end
    end
    
end

