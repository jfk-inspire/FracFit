function [obj_function,xdf_function] = create_model(model,data_type)
% [obj_function,xdf_function] = create_model(model,data_type)
% Sets path and create the objection function and the pdf/cdf function
% associated with the model and the data type.  The data type may be
% either "btc" or "cbtc".

if (not(ischar(model)))
error('model must be a character array');
end

if (not(ischar(data_type)))
error('data_type must be a character array');
end




if (strcmp(model,'spatial_fade'))
  addpath('spatial_fade');
  if (strcmp(data_type,'btc'))
        obj_function = @spatial_fade_obj_function;
        xdf_function = @spatial_fade_pdf_function;
  elseif (strcmp(data_type,'cbtc'))
        obj_function = @spatial_fade_cbtc_obj_function;
        xdf_function = @spatial_fade_ccdf_function;
  else
       error('Data type not supported.');  
  end
  
    
elseif (strcmp(model,'spatial_fade_negskew'))
  addpath('spatial_fade');
   if (strcmp(data_type,'btc'))
        obj_function = @spatial_fade_obj_function;
        xdf_function = @spatial_fade_pdf_function;
   elseif (strcmp(data_type,'cbtc'))
        obj_function = @spatial_fade_cbtc_obj_function;
        xdf_function = @spatial_fade_ccdf_function;
   else
       error('Data type not supported.');  
   end

elseif (strcmp(model,'ade'))        
  addpath('spatial_fade'); 
   if (strcmp(data_type,'btc'))
        obj_function = @spatial_fade_obj_function;
        xdf_function = @spatial_fade_pdf_function;
   elseif (strcmp(data_type,'cbtc'))
        obj_function = @spatial_fade_cbtc_obj_function;
        xdf_function = @spatial_fade_ccdf_function;
   else
       error('Data type not supported.');  
   end
   
elseif  (strcmp(model,'frac_mobile'))
    addpath('frac_mobile');
    if (strcmp(data_type,'btc'))
        obj_function = @frac_mobile_obj_function;
        xdf_function = @frac_mobile_pdf_function;  
    elseif (strcmp(data_type,'cbtc'))
      
    else
       error('Data type not supported.');  
    end
      
elseif (strcmp(model,'frac_mobile_diffusion'))
    addpath('frac_mobile');   
     if (strcmp(data_type,'btc'))
        obj_function = @frac_mobile_diffusion_obj_function;
        xdf_function = @frac_mobile_diffusion_pdf_function;  
     elseif (strcmp(data_type,'cbtc'))
      
     else
       error('Data type not supported.');  
     end
    
else
    error('Model not supported.');         
end

end



