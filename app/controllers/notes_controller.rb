class NotesController < ApplicationController
    before_action :set_note, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
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
       render plain: params[:note].inspect
       @note = Note.new(note_params)
       @note.user = User.first
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
    
    def destroy
       @note = Note.find(params[:id])
       @note.destroy
       flash[:notice] = "Note deleted"
       redirect_to notes_path
    end
    
    private 
    def set_note
      @note = Note.find(params[:id]) 
    end
    
    def note_params
      params.require(:note).permit(:title, :description) 
    end
    
    def require_same_user
      if current_user != @note.user
        flash[:notice] = "Mozna edytowac tylko swoje notatki"
        redirect_to root_path
      end
    end

end