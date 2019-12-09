function gta_output(out_fig,wavelength,das,sas,normdas,normsas,lsv,rsv,fitdata,outdata,rms,time,lifetime,conc,outfilename,kmat)
%[wavelength,time,lifetime,das,sas,normdas,normsas,lsv,rsv,fitdata,outdata,rms,conc,outfilename] = readpyglot()


%%
% 
          
%             out_fig = uifigure('Name','Results');

% Grid1 is created over the uifigure out_fig
           
            out_grid1 = uigridlayout(out_fig);
            out_grid1.RowHeight = {'1x'};
            out_grid1.ColumnWidth= {180,'1x'};

% panel out_p created over the grid1

            out_p = uipanel(out_grid1);
            out_p.Title = outfilename; 
%             p.BorderType = 'none';
           
% Create grid2 in the panel p 
            out_grid2 = uigridlayout(out_p);
            out_grid2.RowHeight = {22, 22, 22, 22};
            out_grid2.ColumnWidth = {'1x'};
%           grid2.ColumnWidth{2} = 0         
            
% axes loads the results directly
            out_ax0 = uiaxes(out_grid1);
            out_ax1 = uiaxes(out_grid1);           
            out_ax0.Layout.Column = 2;
            out_ax0.Layout.Row = 1;       
            out_ax1.Layout.Column = 3;
            out_ax1.Layout.Row = 1;
            
            plot(out_ax0,wavelength,das,"LineWidth",1.5);
            plot(out_ax1,wavelength,normdas,"LineWidth",1.5);
            xlabel(out_ax0,'Wavelength(nm)');
            ylabel(out_ax0,'DAS');
            xlabel(out_ax1,'Wavelength(nm)');
            ylabel(out_ax1,'DAS norm');
            out_ax0.Title.String = 'Parallel Model'
            out_ax1.Title.String = 'Parallel Model'
            
            out_ax2 = uiaxes(out_grid1);
            out_ax3 = uiaxes(out_grid1);   
            out_ax2.Layout.Column = 2;
            out_ax2.Layout.Row = 2;       
            out_ax3.Layout.Column = 3;
            out_ax3.Layout.Row = 2;
            
            plot(out_ax2,wavelength,sas,"LineWidth",1.5);
            plot(out_ax3,wavelength,normsas,"LineWidth",1.5);
            out_ax2.Title.String = 'Target Model'
            out_ax3.Title.String = 'Target Model'
            
            xlabel(out_ax2,'Wavelength(nm)');
            ylabel(out_ax2,'SAS');
            xlabel(out_ax3,'Wavelength(nm)');
            ylabel(out_ax3,'SAS norm');
            
            out_ax4 = uiaxes(out_grid1);
            out_ax5 = uiaxes(out_grid1);
            out_ax4.Layout.Column = 2;
            out_ax4.Layout.Row = 3;       
            out_ax5.Layout.Column = 3;
            out_ax5.Layout.Row = 3;
            
            plot(out_ax4,wavelength,rsv,"LineWidth",1.5);
            plot(out_ax5,time,lsv,"LineWidth",1.5);
            out_ax4.Title.String = 'Right singular vector'
            out_ax5.Title.String = 'Left singular vector'
            xlabel(out_ax4,'Wavelength (nm)');
            ylabel(out_ax4,'Intensity');
            xlabel(out_ax5,'Time (ns)');
            ylabel(out_ax5,'Intensity');
            
            out_ax6 = uiaxes(out_grid1);
            out_ax7 = uiaxes(out_grid1);
            out_ax6.Layout.Column = 4;
            out_ax6.Layout.Row = 1;       
            out_ax7.Layout.Column = 4;
            out_ax7.Layout.Row = 2;
            
            imagesc(out_ax6,wavelength,time,outdata');
            imagesc(out_ax7,wavelength,time,fitdata');
            
            xlabel(out_ax6,'Wavelength(nm)');
            ylabel(out_ax6,'Time (ns)');
            out_ax6.Title.String = 'Original Data'
            xlabel(out_ax7,'Wavelength(nm)');
            ylabel(out_ax7,'Time (ns)');
            out_ax7.Title.String = 'Fitted Data'
            
             out_ax8 = uiaxes(out_grid1);
             out_ax8.Layout.Column = 4;
             out_ax8.Layout.Row = 3;
             plot(out_ax8,time,conc,"LineWidth",1.5);
             xlabel(out_ax8,'Time (ns)');
             ylabel(out_ax6,'Concentration');
             out_ax6.Title.String = 'Concentration profile'            

%%             
% create other requirments 
             % Add method label and drop-down
             % findMethodLabel = uilabel(grid2,'Text','Properties');
             findMethod = uidropdown(out_grid2);
             findMethod.Items = {'Summary','Trace','Nodal'};
             findMethod.ValueChangedFcn = @button_callback;
%              ef = uieditfield(grid2,'numeric','RoundFractionalValues','on');
%%
% call the function of uispinned @gta_updayeSlider             
            spn = uispinner(out_grid2,'Value',1,...
                'Position',[100 140 100 22],'ValueDisplayFormat','%.0f SVD',...
                'ValueChangedFcn',@(spn,event) gta_updateSlider(spn,time,V,out_ax0,ax1,ax2,wavelength,U));
            spn.Limits = [1 15];
%%
% 
       editmax = uieditfield(out_grid2,'numeric','Value', 1,'ValueDisplayFormat','%.0f Crop_Min-wavelength');
%        editmin = uieditfield(out_grid2,'numeric','Value', 0,'ValueDisplayFormat','%.0f Crop_Max-wavelength');
%      uieditfield(grid2);  

       btn = uibutton(out_grid2,'push',...
                        'ButtonPushedFcn', @(btn,event) cropButtonPushed(editmax,editmin));
       btn.Visible = 'off';
%%    
     function button_callback(src,ev)
         method = src.Value;
         switch method
            
             case 'Trace'
                 
               [val] = gta_gettracevalue(editmax);
               gta_plottrace(val,outdata,wavelength,time,fitdata); 
                             
             case 'Nodal'
%                  grid1.RowHeight{2} = 0;
%                  grid1.RowHeight{3} = 0;
                out_grid1.RowHeight{4} = '1x';
                out_ax0 = uiaxes(out_grid1);
                out_ax1 = uiaxes(out_grid1);           
                out_ax0.Layout.Column = [2 4];
                out_ax0.Layout.Row = [1 2];       
                out_ax1.Layout.Column = [2 4];
                out_ax1.Layout.Row = [3 4] ;

                gta_nodal(out_ax0,out_ax1,kmat)
                out_ax0.Box = 'on';
                out_ax1.Box = 'on';
                out_ax0.Title.String = 'Parallal Scheme';
                out_ax1.Title.String = 'Sequential Scheme';
            case 'Summary'
                cla(out_ax0)
                cla(out_ax1)
                out_grid1.RowHeight{4} = 0;
                out_ax0 = uiaxes(out_grid1);
                out_ax1 = uiaxes(out_grid1);           
                out_ax0.Layout.Column = 2;
                out_ax0.Layout.Row = 1;       
                out_ax1.Layout.Column = 3;
                out_ax1.Layout.Row = 1;

                plot(out_ax0,wavelength,das,"LineWidth",1.5);
                plot(out_ax1,wavelength,normdas,"LineWidth",1.5);

                out_ax2 = uiaxes(out_grid1);
                out_ax3 = uiaxes(out_grid1);   
                out_ax2.Layout.Column = 2;
                out_ax2.Layout.Row = 2;       
                out_ax3.Layout.Column = 3;
                out_ax3.Layout.Row = 2;

                plot(out_ax2,wavelength,sas,"LineWidth",1.5);
                plot(out_ax3,wavelength,normsas,"LineWidth",1.5);

                out_ax4 = uiaxes(out_grid1);
                out_ax5 = uiaxes(out_grid1);
                out_ax4.Layout.Column = 2;
                out_ax4.Layout.Row = 3;       
                out_ax5.Layout.Column = 3;
                out_ax5.Layout.Row = 3;

                plot(out_ax4,wavelength,rsv,"LineWidth",1.5);
                plot(out_ax5,time,lsv,"LineWidth",1.5);

                out_ax6 = uiaxes(out_grid1);
                out_ax7 = uiaxes(out_grid1);
                out_ax6.Layout.Column = 4;
                out_ax6.Layout.Row = 1;       
                out_ax7.Layout.Column = 4;
                out_ax7.Layout.Row = 2;

                imagesc(out_ax6,wavelength,time,outdata');
                imagesc(out_ax7,wavelength,time,fitdata');

                 out_ax8 = uiaxes(out_grid1);
                 out_ax8.Layout.Column = 4;
                 out_ax8.Layout.Row = 3;
                 plot(out_ax8,time,conc,"LineWidth",1.5);

                
                

                



%% works
%                 grid1.RowHeight{2} = 0;
%                 grid2.RowHeight{3} = 0;
%                 gta_cropdata(650,750,wavelength,dataf)
%                [cutdata,wavelengthcut] = gta_cropdata(650,750,wavelength,dataf)
%                 imagesc(ax,wavelengthcut,time,cutdata');
                
                

     
          end
       end
                 
                
end