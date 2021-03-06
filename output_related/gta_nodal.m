function gta_nodal(kmat,out_fig,t,t1)


% [c2,c1,ra] = find(kmat)
ra = diag(kmat)
% ra = 1./ra
ra = -ra
ra = 1./ra
gloK = diag(ra)
A = diag(ra,-1)
A1 = A(:,1:end-1)
req = A1(size(A1,1),size(A1,2))
A1(size(A1,2),size(A1,2)) = req
seqK = A1(1:end-1,:)

[gloC2,gloC1,glora] = find(gloK)
[seqC2,seqC1,seqra] = find(seqK)

% figure(10)
out_fig = uitab(t)
out_fig.Title = t1;
out_fig.BackgroundColor = '#06470c';
out_fig.ForegroundColor = '#06470c';
g = uigridlayout(out_fig,[1,1])

Glo = digraph(gloC1,gloC2,glora)
out_ax0 = uiaxes(g)
out_ax0.Layout.Column = 1;
out_ax0.Layout.Row = 1;   

H_Glo = plot(out_ax0,Glo,'EdgeLabel',Glo.Edges.Weight,'Layout','force','ArrowSize',10)
H_Glo.NodeColor = 'm'
H_Glo.LineWidth = 2.5
% H_Glo.LineStyle = '--';
H_Glo.MarkerSize = 40
H_Glo.Marker = 'o';
H_Glo.ArrowPosition = 0.8 ;
H_Glo.EdgeColor = [0 0.4470 0.7410];
H_Glo.EdgeLabelColor = 'r';
H_Glo.NodeFontSize = 25;
H_Glo.ArrowSize = 20
H_Glo.EdgeFontSize = 15;
H_Glo.NodeFontWeight = 'bold'
%  legend( 'Parallal Model');


%         layout(H_Glo,'layered','direction','down')
% figure(11)
out_ax1 = uiaxes(g)
out_ax1.Layout.Column = 1;
out_ax1.Layout.Row = 2; 
Seq = digraph(seqC1,seqC2,seqra)
H_Seq = plot(out_ax1,Seq,'EdgeLabel',Seq.Edges.Weight,'Layout','force','ArrowSize',10)
%         layout(H_Seq,'layered','direction','down')
H_Seq.NodeColor = 'm'
H_Seq.LineWidth = 2.5
% H_Seq.LineStyle = '-';
H_Seq.MarkerSize = 40
H_Seq.Marker = 'o';
H_Seq.ArrowPosition = 0.8;
H_Seq.ArrowSize = 20
H_Seq.EdgeColor = [0 0.4470 0.7410];
H_Seq.EdgeLabelColor = 'r';
H_Seq.NodeFontSize = 25;
H_Seq.NodeFontWeight = 'bold';

H_Seq.EdgeFontSize = 15;
                out_ax0.Box = 'on';
                out_ax1.Box = 'on';
                out_ax0.Title.String = 'Parallal Scheme';
                out_ax1.Title.String = 'Sequential Scheme';
end
%  legend( 'Sequential / Target Model');