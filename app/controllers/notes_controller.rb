class NotesController < ApplicationController
    
    def index
        @notes = Note.all    
    end
    
   def new
       @note = Note.new
   end
   
   def show
      @note = Note.find(params[:id]) 
   end
   
   def create
       #render plain: params[:note].inspect
       @note = Note.new(note_params)
       if @note.save
           flash[:notice] = "Note saved"
           redirect_to note_path(@note)
       else
           render 'new'
       end
   end
   
   def edit
       @note = Note.find(params[:id])
   end
   
   def update
      @note = Note.find(params[:id])
      
      if @note.update(note_params)
          flash[:notice] = "Note updated"
          redirect_to note_path(@note)
      else
         render 'edit' 
      end
   end
   
   private 
   def note_params
      params.require(:note).permit(:title, :description) 
   end
end