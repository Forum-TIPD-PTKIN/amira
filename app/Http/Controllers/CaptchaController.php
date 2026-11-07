<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

class CaptchaController extends Controller
{
    public function generate()
    {
        $num1 = rand(1, 10);
        $num2 = rand(1, 10);
        $answer = $num1 + $num2;
        $question = "{$num1} + {$num2} = ?";

        Session::put('login_captcha', (string) $answer);

        return response()->json([
            'question' => $question,
        ]);
    }
}
