function h = scatter_kdeModified(x, y, ch1,ch2,varargin)
% Scatter plot where each point is colored by the spatial density of nearby
% points. The function use the kernel smoothing function to compute the
% probability density estimate (PDE) for each point. It uses the PDE has
% color for each point.
%
% Input
%     x <Nx1 double> position of markers on X axis
%     y <Nx1 double> posiiton of markers on Y axis
%     varargin can be used to send a set of instructions to the scatter function
%           Supports the MarkerSize parameter
%           Does not support the MarkerColor parameter
%
% Output:
%     h returns handles to the scatter objects created
%
% Example
%     % Generate data
%     x = normrnd(10,1,1000,1);
%     y = x*3 + normrnd(10,1,1000,1);
%     % Plot data using probability density estimate as function
%     figure(1); 
%     scatter_kde(x, y, 'filled', 'MarkerSize', 100);
%     % Add Color bar
%     cb = colorbar();
%     cb.Label.String = 'Probability density estimate';
%
% author: Nils Haentjens
% created: Jan 15, 2018
% Use Kernel smoothing function to get the probability density estimate (c)
c = ksdensity([x,y], [x,y]);
figure
h = subplot(2,2,2);
if nargin > 4
  % Set Marker Size
  i = find(strcmp(varargin, 'MarkerSize'),1);
  if ~isempty(i); MarkerSize = varargin{i+1}; varargin(i:i+1) = [];
  else MarkerSize = []; end
  % Plot scatter plot
  scatter(x, y, MarkerSize, c, varargin{:});
  set(gca,'ytick',[])
  set(gca,'xtick',[])
  %box off
  xlim([min(x)-10 0])
  ylim([min(y)-10 0])
  set(gca,'XAxisLocation','top','YAxisLocation','right');
  xlabel(['Channel ', num2str(ch1)])
  ylabel(['Channel ', num2str(ch2)])
else
  h = scatter(x, y, [], c);
end

end