% =========================================================================
%  Title: Triply-Periodic Minimal Surface with edge dislocation
%  Authors: Luca D'Andrea and Pasquale Vena
%  email: luca.dandrea@polimi.it
%  Date: 05 November 2024
%  Cite as: D'Andrea L., Yang T., Dao M., Vena P., Nature‑inspired 
%  orientation‑dependent toughening mechanism for TPMS ceramic architectures
%  MRS Bulletin 2025, doi:10.1557/s43577-024-00831-5
% =========================================================================

% Generate TMPS with edge dislocation

% =========================================================================
%
% In the first section of the code the 3D binary image is generated by
% setting the number of repetitive cells, the pixels per edge, and the two
% parameters affecting the porosity (b and d). Set geo to set the geoemtry
%
% In the second section the image is saved as tiff file.
%
% =========================================================================

clear all
clc

% select the geometry:
% geo = 1 -> Primitive
% geo = 2 -> IWP
% geo = 3 -> Neovius
% geo = 4 -> Lidinoid
% geo = 5 -> Gyroid

geo = 1;

% half of repetitive units per direction (N in the paper)
c = 4;

% parameters affecting the porosity
b = 0.8;
d = 0.4;

% number of pixel per direction
nn = 15;
n = 2*2*c*nn+1;

% initialization of the matrix

AAA = 1;

M1 = zeros((n-1),(n-1)*AAA,(n-1)/c);
p = 1;
mid = c/2;
cel = 0.5;
grr1 = mid-1*p;
grr2 = mid+0.5*p;
esp = 12*p/AAA+AAA;

grx = linspace(0,cel,(mid+grr1)/c*(n-1)-(mid-grr2)/c*(n-1));
grx2 = grx.^esp/grx(end)^esp*cel;

for z = 1:(n-1)/c
    for y = 1:(n-1)*AAA
        a = 0;
        for x = 1:(n-1)*2

            if x <= (mid-grr1)/c*(n-1)
                if geo == 1
                    f(x,y,z) = cos(2*pi*x*c/n)+cos(2*pi*y*c/n)+cos(2*pi*z*c/n)+b;
                elseif geo == 2
                    f(x,y,z) = 2*cos(2*pi*x*c/n)*cos(2*pi*y*c/n) + 2*cos(2*pi*y*c/n)*cos(2*pi*z*c/n) + 2*cos(2*pi*x*c/n)*cos(2*pi*z*c/n) - cos(4*pi*x*c/n) - cos(4*pi*y*c/n) - cos(4*pi*z*c/n) + b;
                elseif geo == 3
                    f(x,y,z) = 3*(cos(2*pi*x*c/n)+cos(2*pi*y*c/n)+cos(2*pi*z*c/n))+4*cos(2*pi*x*c/n)*cos(2*pi*y*c/n)*cos(2*pi*z*c/n) +b;
                elseif geo == 4
                    f(x,y,z) = 1/2*(sin(4*pi*x*c/n)*cos(2*pi*y*c/n)*sin(2*pi*z*c/n) + sin(4*pi*y*c/n)*cos(2*pi*z*c/n)*sin(2*pi*x*c/n) + sin(4*pi*z*c/n)*cos(2*pi*x*c/n)*sin(2*pi*y*c/n)) - 1/2*(cos(4*pi*x*c/n)*cos(4*pi*y*c/n) + cos(4*pi*y*c/n)*cos(4*pi*z*c/n) + cos(4*pi*z*c/n)*cos(4*pi*x*c/n))+b;
                elseif geo == 5
                    f(x,y,z) = sin(2*pi*x*c/n)*cos(2*pi*y*c/n)+ sin(2*pi*y*c/n)*cos(2*pi*z*c/n)+ sin(2*pi*z*c/n)*cos(2*pi*x*c/n)+b;
                end

            elseif x > (mid-grr1)/c*(n-1) && x < (mid+grr2)/c*(n-1)
                a = a+1;
                cg = c+grx2(a);
                if geo == 1
                    f(x,y,z) = cos(2*pi*x*c/n)+cos(2*pi*y*cg/n)+cos(2*pi*z*c/n)+b;
                elseif geo == 2
                    f(x,y,z) = 2*cos(2*pi*x*c/n)*cos(2*pi*y*cg/n) + 2*cos(2*pi*y*cg/n)*cos(2*pi*z*c/n) + 2*cos(2*pi*x*c/n)*cos(2*pi*z*c/n) - cos(4*pi*x*c/n) - cos(4*pi*y*cg/n) - cos(4*pi*z*c/n) + b;
                elseif geo == 3
                    f(x,y,z) = 3*(cos(2*pi*x*c/n)+cos(2*pi*y*cg/n)+cos(2*pi*z*c/n))+4*cos(2*pi*x*c/n)*cos(2*pi*y*cg/n)*cos(2*pi*z*c/n) +b;
                elseif geo == 4
                    f(x,y,z) = 1/2*(sin(4*pi*x*c/n)*cos(2*pi*y*cg/n)*sin(2*pi*z*c/n) + sin(4*pi*y*cg/n)*cos(2*pi*z*c/n)*sin(2*pi*x*c/n) + sin(4*pi*z*c/n)*cos(2*pi*x*c/n)*sin(2*pi*y*cg/n)) - 1/2*(cos(4*pi*x*c/n)*cos(4*pi*y*cg/n) + cos(4*pi*y*cg/n)*cos(4*pi*z*c/n) + cos(4*pi*z*c/n)*cos(4*pi*x*c/n))+b;
                elseif geo == 5
                    f(x,y,z) = sin(2*pi*x*c/n)*cos(2*pi*y*cg/n)+ sin(2*pi*y*cg/n)*cos(2*pi*z*c/n)+ sin(2*pi*z*c/n)*cos(2*pi*x*c/n)+b;
                end

            elseif x >= (mid+grr2)/c*(n-1)
                cc = c+cel;
                if geo == 1
                    f(x,y,z) = cos(2*pi*x*c/n)+cos(2*pi*y*cc/n)+cos(2*pi*z*c/n)+b;
                elseif geo == 2
                    f(x,y,z) = 2*cos(2*pi*x*c/n)*cos(2*pi*y*cc/n) + 2*cos(2*pi*y*cc/n)*cos(2*pi*z*c/n) + 2*cos(2*pi*x*c/n)*cos(2*pi*z*c/n) - cos(4*pi*x*c/n) - cos(4*pi*y*cc/n) - cos(4*pi*z*c/n) + b;
                elseif geo == 3
                    f(x,y,z) = 3*(cos(2*pi*x*c/n)+cos(2*pi*y*cc/n)+cos(2*pi*z*c/n))+4*cos(2*pi*x*c/n)*cos(2*pi*y*cc/n)*cos(2*pi*z*c/n) +b;
                elseif geo == 4
                    f(x,y,z) = 1/2*(sin(4*pi*x*c/n)*cos(2*pi*y*cc/n)*sin(2*pi*z*c/n) + sin(4*pi*y*cc/n)*cos(2*pi*z*c/n)*sin(2*pi*x*c/n) + sin(4*pi*z*c/n)*cos(2*pi*x*c/n)*sin(2*pi*y*cc/n)) - 1/2*(cos(4*pi*x*c/n)*cos(4*pi*y*cc/n) + cos(4*pi*y*cc/n)*cos(4*pi*z*c/n) + cos(4*pi*z*c/n)*cos(4*pi*x*c/n))+b;
                
                elseif geo == 5
                f(x,y,z) = sin(2*pi*x*c/n)*cos(2*pi*y*cc/n)+ sin(2*pi*y*cc/n)*cos(2*pi*z*c/n)+ sin(2*pi*z*c/n)*cos(2*pi*x*c/n)+b;
                end
            end

            if f(x,y,z) < d && f(x,y,z) > (-1*d)
                M1(x,y,z) = 1;
                M_q(x,y) = M1(x,y,z);
            else
                M1(x,y,z) = 0;
                M_q(x,y) = M1(x,y,z);
            end
        end
    end
end

M1 = uint8(M1);
M2 = flip(M1,1);
M3 = imrotate(M2,180);
MM = cat(2,M1,M3);
volumeViewer(MM)

%% Write the file

scaff = uint8(double(MM.*255));
for k = 1:size(scaff,3)
    imwrite(scaff(:,:, k), 'dislocation.tif', 'WriteMode', 'append');
end
