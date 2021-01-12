#pragma once


namespace Project1 {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	float leaf[] =
	{
		//левый лист
		2.5f,2.f,3.f,1.5f,
		2.5f,1.5f,2.5f,2.f,
		3.5f,1.f,2.5f,1.5f,
		1.5f,0.5f,1.f,0.5f,
		2.5f,1.f,1.5f,0.5f,
		3.f,1.f,2.5f,1.f,
		3.f,0.5f,3.f,1.f,
		3.5f,0.5f,3.f,0.5f,
		3.5f,1.f,3.5f,0.5f,
		1.f,0.5f,2.f,1.5f,
		2.f,1.5f,0.5f,1.5f,
		0.5f,1.5f,1.f,2.f,
		1.f,2.f,2.f,2.f,
		2.f,2.f,1.f,3.f,
		1.f,3.f,1.f,3.5f,
		1.f,3.5f,1.5f,3.5f,
		1.5f,3.5f,3.f,2.f,
		3.f,2.f,3.5f,2.f,

		//правый лист
		6.5f,1.5f,7.f,2.f,
		7.f,2.f,8.f,2.f,
		8.f,2.f,8.5f,2.5f,
		8.5f,2.5f,7.5f,2.5f,
		7.5f,2.5f,8.f,3.f,
		8.f,3.f,9.5f,3.f,
		9.5f,3.f,10.f,3.5f,
		10.f,3.5f,8.5f,3.5f,
		8.5f,3.5f,8.5f,4.f,
		8.5f,4.f,10.f,4.f,
		10.f,4.f,9.5f,4.5f,
		9.5f,4.5f,8.5f,4.5f,
		8.5f,4.5f,9.5f,5.5f,
		9.5f,5.5f,9.5f,6.f,
		9.5f,6.f,9.f,6.f,
		9.f,6.f,8.f,5.f,
		8.f,5.f,8.f,6.f,
		8.f,6.f,7.5f,6.5,
		7.5f,6.5f,7.5f,5.f,
		7.5f,5.f,7.f,5.f,
		7.f,5.f,7.f,6.f,
		7.f,6.f,6.5f,6.5f,
		6.5f,6.5f,6.5f,5.5f
	};
	float flame[] =
	{
		//пламя
		4.5f,8.f,5.5f,8.f,
		5.5f,8.f,6.5f,9.f,
		6.5f,9.f,6.5f,9.5f,
		6.5f,9.5f,5.f,13.f,
		5.f,13.f,3.5f,9.5f,
		3.5f,9.5f,3.5f,9.f,
		3.5f,9.f,4.5f,8.f,
        //внутрений радиус
		5.f,7.5f,6.5f,7.5f,
		6.5f,7.5f,7.5f,10.f,
		7.5f,10.f,7.f,11.5f,
		7.f,11.5f,6.f,13.f,
		6.f,13.f,4.f,13.f,
		4.f,13.f,3.f,11.5f,
		3.f,11.5f,2.5f,10.f,
		2.5f,10.f,3.5f,7.5f,
		3.5f,7.5f,5.f,7.5f,
		//внешний радиус
		5.f,7.f,6.5f,7.f,
		6.5f,7.f,8.5f,9.f,
		8.5f,9.f,8.5f,12.f,
		8.5f,12.f,6.5f,14.f,
		6.5f,14.f,3.5f,14.f,
		3.5f,14.f,1.5f,12.f,
		1.5f,12.f,1.5f,9.f,
		1.5f,9.f,3.5f,7.f,
		3.5f,7.f,5.f,7.f
	};
	float candle[] =
	{
		//свеча
		3.5f,1.f,4.f,0.5f,
		4.f,0.5f,6.f,0.5f,
		6.f,0.5f,6.5f,1.f,
		6.5f,1.f,6.5f,5.f,
		6.5f,4.5f,7.f,4.5f,
		7.f,4.5f,7.f,5.f,
		7.f,5.f,5.5f,6.5f,
		5.5f,6.5f,4.5f,6.5f,
		4.5f,6.5f,3.5f,5.5f,
		3.5f,5.5f,3.5f,5.f,
		3.5f,5.f,2.5f,4.f,
		2.5f,4.f,2.5f,3.5f,
		2.5f,3.5f,3.f,3.5f,
		3.f,3.5f,3.5f,4.f,
		3.5f,4.f,3.5f,4.5f,
		3.5f,4.f,3.5f,3.5f,
		3.5f,3.5f,3.f,3.f,
		3.f,3.f,3.f,2.5f,
		3.f,2.5f,3.5f,2.5f,
		3.5f,2.5f,3.5f,3.f,
		3.5f,2.5f,3.5f,1.f
	};
	float wick[] =
	{
		5.f,6.5f,5.f,8.f
	};
	float Vx = 10.5f;
	float Vy = 14.5f;
	unsigned int WickLength = sizeof(wick) / sizeof(float);
	unsigned int CandleLength = sizeof(candle) / sizeof(float);
	unsigned int LeafLength = sizeof(leaf) / sizeof(float);
	unsigned int FlameLength = sizeof(flame) / sizeof(float);

	/// <summary>
	/// Summary for MyForm
	/// </summary>
	public ref class MyForm : public System::Windows::Forms::Form
	{
	public:
		MyForm(void)
		{
			InitializeComponent();
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~MyForm()
		{
			if (components)
			{
				delete components;
			}
		}

	private:
		/// <summary>
		/// Required designer variable.
		/// </summary>
		System::ComponentModel::Container ^components;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			this->SuspendLayout();
			// 
			// MyForm
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(224, 195);
			this->DoubleBuffered = true;
			this->Name = L"MyForm";
			this->Text = L"MyForm";
			this->Load += gcnew System::EventHandler(this, &MyForm::MyForm_Load);
			this->Paint += gcnew System::Windows::Forms::PaintEventHandler(this, &MyForm::MyForm_Paint);
			this->KeyDown += gcnew System::Windows::Forms::KeyEventHandler(this, &MyForm::MyForm_KeyDown);
			this->Resize += gcnew System::EventHandler(this, &MyForm::MyForm_Resize);
			this->ResumeLayout(false);

		}
#pragma endregion
	private: bool KeepAspectRatio;
	private: System::Void MyForm_Paint(System::Object^  sender, System::Windows::Forms::PaintEventArgs^  e) 
	{
		Graphics^ g = e->Graphics;
		g->Clear(Color::White);
		Pen^ redPen = gcnew Pen(Color::Red,2);
		Pen^ yellowPen = gcnew Pen(Color::Yellow,2);
		SolidBrush^ drawBrush = gcnew SolidBrush(Color::Black);
		System::Drawing::Font^ drawFont = gcnew System::Drawing::Font("Arial", 10);
		Pen^ greenPen = gcnew Pen(Color::Green, 2);
		Pen^ blackPen = gcnew Pen(Color::Black, 2);
		float Wx = ClientRectangle.Width;
		float Wy = ClientRectangle.Height;
		float aspectFig = Vx / Vy;
		float aspectForm = Wx / Wy;
		float Sx, Sy;
		if (KeepAspectRatio)
		{
			Sx = Sy = aspectFig < aspectForm ? Wy / Vy : Wx / Vx;
		}
		else
		{
			Sx = Wx / Vx;
			Sy = Wy / Vy;
		}
		float Ty = Sy * Vy; 


		for (int i = 0; i < CandleLength; i += 4) {
			g->DrawLine(redPen, Sx * candle[i],Ty -Sy * candle[i + 1]
				, Sx * candle[i + 2],Ty -Sy * candle[i + 3]);
		}
		for (int i = 0; i < FlameLength; i += 4) {
			g->DrawLine(yellowPen, Sx * flame[i], Ty - Sy * flame[i + 1]
				, Sx * flame[i + 2], Ty - Sy * flame[i + 3]);
		}
		for (int i = 0; i < LeafLength; i += 4) {
			g->DrawLine(greenPen, Sx * leaf[i], Ty - Sy * leaf[i + 1]
				, Sx * leaf[i + 2], Ty - Sy * leaf[i + 3]);
		}
		for (int i = 0; i < WickLength; i += 4) {
			g->DrawLine(blackPen, Sx * wick[i], Ty - Sy * wick[i + 1]
				, Sx * wick[i + 2], Ty - Sy * wick[i + 3]);
		}

	}
	private: System::Void MyForm_Resize(System::Object^  sender, System::EventArgs^  e) 
	{
		Refresh();
	}
	private: System::Void MyForm_Load(System::Object^ sender, System::EventArgs^ e) 
	{
		KeepAspectRatio = true;
	}
	private: System::Void MyForm_KeyDown(System::Object^ sender, System::Windows::Forms::KeyEventArgs^ e) 
	{
		switch (e->KeyCode)
		{
		case Keys::M :
			KeepAspectRatio = !KeepAspectRatio;
			break;
		default:
			break;
		}
		Refresh();
	}
	};
}
