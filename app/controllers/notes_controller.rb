class NotesController < ApplicationController
   def new
       @note = Note.new
   end
   
   def create
       #render plain: params[:note].inspect
       @note = Note.new(note_params)
       @note.save
       redirect_to notes_show(@note)
   end
   
   private 
   def note_params
      params.require(:note).permit(:title, :description) 
   end
end